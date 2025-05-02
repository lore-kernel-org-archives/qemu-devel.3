Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669AEC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAt7B-0001J2-Gs; Fri, 02 May 2025 12:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uAt79-0001It-7G
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:19:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uAt77-0004YZ-5v
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:19:50 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542FfofK002180;
 Fri, 2 May 2025 16:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Yxw1XCT6gBKI+XI9Cyl4Hy4WBVCIX6PE3sV3b+TcemU=; b=
 qg3hSUYto2MwMBs37AGdh5AKw6HK70QebOYuqp7b3CyGKJE1RDzFurDyWHV7Ujtq
 XNzQKTfFuS6KPXF2oMm17q90gS1fhXPvCJ6Q5gT+cloDsizQqqxzBM/HZBwDrOcL
 nfNfdVVqrj6OU1yWjVRWfy+AZffzpAB8UrgRLCyDWqGmBMVSRN6yPEdCUjvCOjCH
 GF3ProEyfZ40RPzDPAVrmyzJkbb5slGbXpzU/B+T4vM9rFRZUmiYlBQLlz9wxVA4
 TporT60e5Wf6CdwjcsslJxV2hRWAS3zEN8IeyOUQcGdy5arpHfJ3etLFp/sEj6Eh
 Oo6+baf3OsgjJdZvQJk6Hg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uknp21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 16:19:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 542F3vCp023794; Fri, 2 May 2025 16:19:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxm71pc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 16:19:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTJRpTBfducO+UiPg1arlCacSQFbAhaJQejTKAuXI1cVmYTGAiKb6AXkt5BaSQh+DGscd2ufsXfWQfcXxroHSDwgodN1zkWGZRoY9WummQwRQrZP14PoTL9SmsTCxPxHm9+PzKjdJz9J6JEPFcec2FZ1EDCGGnjWowrBiJp/YquVnXaG/IliN3mzhxBOBEOYEUE2doCPQXeii0NAhMa9agD5eqQZd9RVeRqmAFw2FspPWLY+lJ95ckgfDSNbAzz94B7YO6xS0bU4jX8+RWf2kWqm7dd6XOLYGOoGadPynJ+fJ7SZ5FQ7PGLHq9YeBZXigZoOwMGpH4Ss95qN3wCNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yxw1XCT6gBKI+XI9Cyl4Hy4WBVCIX6PE3sV3b+TcemU=;
 b=hKAIR7nN9+8/W2XuvsCBJBFGqCbSjaIZzCimvxiwUtVHiMM7zH73Uuac9ogwD9xk4FkXrjPJZMU88jvoLWmDV4INzlveKdL0H2GEv6qzYSAXpKQKGtw4x4rUUyuj6bKeXVdee1vstAUxQk8I1KrPZN++2/+KQnz/g5/RkGFU+9FRrgUgNLa2+XbEy1+zBvn6rx2EbPYj0c+aB5UFqqj47sRDKA8wrnsyCDnzQR3qej688wnLZaGo1qxknspZbA+Kw4IBrZYO4qbLtknRJ9sKdAZGW86sdLeulfBFIQqIT8tGpouufpmsTxkKynU9irfZS64X0xz9rL+Yw+7GQZUU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yxw1XCT6gBKI+XI9Cyl4Hy4WBVCIX6PE3sV3b+TcemU=;
 b=lBfYaVeaD9NizVpyaAAqtEar6bcckkT70ogwoDEAgBTs5MhUPaBQ8WfbLgivjooUiNKXzpaXS0gFcO5yYMZ/8nepbAd+ne2PNFae8OIL3j2ohKfMX57rWn6dEUxJ2hZ6bcyVi1k5Jmua84bVNkEPzeP96xn6cx/4QzftI3vQtk8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ1PR10MB5930.namprd10.prod.outlook.com (2603:10b6:a03:48b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 2 May
 2025 16:19:39 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 16:19:39 +0000
Message-ID: <afdd9721-8560-468f-8deb-674dd0873892@oracle.com>
Date: Fri, 2 May 2025 12:19:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/6] fast qom tree get
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, devel@lists.libvirt.org
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org>
 <86bb6d0f-63a1-4643-b58a-1186a73e3b17@oracle.com>
 <87selszp8o.fsf@pond.sub.org>
 <3c5e9e8d-a3c5-4179-800f-2c11d38b7b02@oracle.com>
 <87v7qnpksp.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87v7qnpksp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0080.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::21) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ1PR10MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd0cda4-8b22-46c7-397c-08dd899522c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWFzbEQvWmJscFM3dUJjZTY1YUNuN1JjcllVUDN5KzFwM01YOWFWQUVZUlJs?=
 =?utf-8?B?MDhDNGplOHlBLzhLWHgxZ3EwVjB3bkJnbkh4b1pkSWNieWhCNWRUOFpYMERj?=
 =?utf-8?B?RjVCOEFLUHlHZVIzNVFCbEs5VVpZQmF0Nm5LUVMvOEsvQUw0Vk9XcnBDdHF4?=
 =?utf-8?B?N2I4SGlTb050K2lTMUo5TTY4WmE5ZHlUdk12UndUZXN4cjhxVDhreGQwdG1p?=
 =?utf-8?B?SHhERFRIcTVrQ0R2OVJGZy9RU1JmN2pkV2ZFU0MyM2s4Uy9NLy93UjJoMm53?=
 =?utf-8?B?b1o1cDZoelJSMU9GT043UFI3Um1vZTJZOVoxdkJ6OURhc0N1SlZyRW1WV0JG?=
 =?utf-8?B?OVJFdXh3ZVVQTDZsYml3bUtDSTNxK21meU5zUHJTb3FQeExQTVd1UFozVW54?=
 =?utf-8?B?c0hjbFN3VGNaWSs0bUZrOXhYZ2ZDL3ZyMy9xMVJ4T3RIbWMycktGVGtwY1I4?=
 =?utf-8?B?YUVINXVJeTRMSDF2WjFhd0tZb0JVNDd1ZVZBRVUrVXRXU3pkNnV4bXNUZ0FB?=
 =?utf-8?B?elQwcjNaN0lONlRPQkdxREZDOEY5SFB3R0FpMjBUQ0ZrV2RuMUJ0YTlhQWwy?=
 =?utf-8?B?c2htd2NWQ2ZQSC9pbXFSamFiSnR2bDFuSndxbnhCQyt3STFLVFdWOVEzRXcv?=
 =?utf-8?B?TUhtL0hRa1YwRWliVHE0T1VLY0VmNVhuWGRRS0l2Nkc1cDNVUThRWG9vb1d1?=
 =?utf-8?B?UzBKQUpJeGZVZ01wK0s0Q3pZcGRtRDYxWUNXTnYzSlAyeFhidGNpTCtXbG02?=
 =?utf-8?B?d0RkT0VYclFtakhtQWRBbjdpaXpIUFFEVnVydU44NmhCQmJwdVJBNStXQUh5?=
 =?utf-8?B?cnFUQlhqMG1iRWdPLzhLeTJoTGh3WTM3YnhpUENabC9jd1BRdS9jYlFvd3J5?=
 =?utf-8?B?djZoc3NXL2Y1SGdSY05OeVVpaFRPREJxOVV2TGFoalVoV09xNURHbG40OC8y?=
 =?utf-8?B?enBlSjFTcDdkSlEyZEZXNDFJREVDZlNldGg1ZnF1N2pmN21SMzJXUTZ1L2Uw?=
 =?utf-8?B?ejNudVNlalJzOTBlcThZdCs2L1JkTmw5SFh4RHBsckczZGxvL2MrRmtCZ0dF?=
 =?utf-8?B?Mno0eEtSUjNjOURGS01nUFgrQVBJUzlnbktuRExicCtOeGc5cExYMFdwdGNm?=
 =?utf-8?B?QVdMRlZlVCsvTUVlM2dMNzM0WEJtcjFBbHJoWEV1YmhQOW5Sc2ZvM3hna0Jy?=
 =?utf-8?B?dzJzYU5VRjNYQ1JRRmNHdXJYaWVwVlVyazZDcTFqcStCTTJoVkw0OGN1cWIv?=
 =?utf-8?B?Rk00bEZ6TWMxaXJQZUhjTFBLblozZVZOY1c4cUUvQmphR1c2TDNkbFFHYS9B?=
 =?utf-8?B?V2FuTWFYaXpNbC9YUTZNSWdyV3pCNmlBd1RXZHF2THZUR3dudXVjMDN3Z2ti?=
 =?utf-8?B?MDJJdnhjekNRcXY3aDFQS0E1QU5oZ1pSa3MrVFlyUkNKOW9XN1l6RWVKZ3dH?=
 =?utf-8?B?UG81aUFZejZwTkloUlpuVlhKZklBMUJXWmVMQzhzSHFoTGowWDRka0ZkT1NV?=
 =?utf-8?B?M1RFdTl3ekNhYVlWKzRTdm9FQVNLT204SHJwN2pxMlhuOWszWURrd2RpMXJC?=
 =?utf-8?B?WERSOFBuaGx2ZysyR3JRMHZPSnlHRUo2U0VpTlZMNkZkSlpBM3B6b05Yd3cr?=
 =?utf-8?B?RHBjOUdtUExQb0hGNWdtZGw2bE9Xd0VpUzJiNHVYcnk1TTRuME9kSk56NW4w?=
 =?utf-8?B?cTVURkwvR2RjeEFjbC9KT2kzSUVRNnI1RVI4K0ovTXhXanRlckRaT3dKeThq?=
 =?utf-8?B?MDZGOTE1MjF2NmVaWTFFemd2ZndQekdwcXBoMXFSakpheUhVcHora1RvNlhv?=
 =?utf-8?B?Ymp3cTJXOE8vU29TQklsVE9oNHA0WDFPbGdLUHNiRlJqeitwS3drZUgzYjJT?=
 =?utf-8?B?MzEyZUl4ajN3aFZMWmVJeG55YnFkTmRuQUVUNGtZcWVTS2UwdGRHREl0cXIx?=
 =?utf-8?Q?scEiV5qOS+E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2wzNFpwY1JMRi9KZnM1K0dRaEdEeFVkUHhVMkkzanpUemt0ZUpRYjZPZEpE?=
 =?utf-8?B?b1loRUJYcUJBc2JuaThRbk9mNWQ5b013RklSN25veTV2b05kTUdDdStyNGJy?=
 =?utf-8?B?K1JrK3l0QWxaemZRUGpUR3pZWG8xL24zNWhxNUprKzhHaGtwaWZ2L2NYSDhS?=
 =?utf-8?B?Mk1MWHl6VkpuT0N1a2RvZ1gzcWc3R3QveThnYlRPaWRLV3dYWUdwMTgwNUMy?=
 =?utf-8?B?WUdwTmVBWGNONlltMXAyRExES3FFZHRJbk93bjE3a1pCY0ZqQkl3K3F3U1hG?=
 =?utf-8?B?M1orYWltUzZjckVmcG14c2sya2wzQ3NrMWdlZ0p1V2FTZGVJY3IzSWtnSFdF?=
 =?utf-8?B?RGZtdjZwd1U5Q2VERTYyNGM5S2hjc0lVb0lsd3Z5ZWJjU3pxYzNvNDVSR2hn?=
 =?utf-8?B?dlIvRm5kRTEvNnBML0xBeDF1cjFDbHBPdHJtL2lIU01PdnUxN2hhL0RsQ1dt?=
 =?utf-8?B?MHZ3UnZDT0M1M0FhYWt6S3Z0c3FpR2E1VzZLaGphSDh1MHlUUzcwZmFwd2ZO?=
 =?utf-8?B?RXJWQlN6L09rQjl1TWV2T0p6UWQ2elViWG16ODJGNngvNkh0R3FTbEZxUzFY?=
 =?utf-8?B?OVFLWmZ0UnowM2NON3lIY3dKRWFWdDJMcGJjQ2xYWFk2SHBCelNUcC9zdzZs?=
 =?utf-8?B?UmdqTmtNcEtxRWdiVHVoa2MzQUxtZFlES25QVVhnZkI0OURwVVE4cjRYcS83?=
 =?utf-8?B?ZGpoOHQ0ZHIvOFVBUlllZWlaQ1lNeVdmWG45bkhZTlA1ZDJxT21PQSs0NWVt?=
 =?utf-8?B?T2F4d1FabTdhM2hQbG5tMWJHWjg1aFEyMTdZdllNRVJabVNDREZaU1BYUXp2?=
 =?utf-8?B?N0t0d3pMMm1DTXhaZ1lPQkNqajBxM0hidlgzeHk0RTg0QThuTEo4WUJib0dx?=
 =?utf-8?B?TVFoSVY5OFM4eDRoRnhLK3JGVHFnZjZlcjBaa2JoRlZvYnFZTHlUaitUQ2R4?=
 =?utf-8?B?d0NNMmszR1h3Ritob2VDMGU5WGMrWWgxT094bTVXbG5QUm95TEI0Y28vVjBP?=
 =?utf-8?B?UHVBS0tkUnQ1cnlqRmlSUVNYYXhpK3NIMWxpVllVanBEMHJsWUQ4V1JxRzU3?=
 =?utf-8?B?VlZMaHhBQUUwME1naXF6VGMvOUdKTlpqZVN1UTFNVURoT1pSbit2OUJPcHZV?=
 =?utf-8?B?RklrdTllbkc4TXo5TDhCbmtUaDV2ZXF1aUZab0tES0YrL1NCLzY3Ni80ZDhM?=
 =?utf-8?B?VUQ2ZFV3YzIrTEUvWE9vZy9CaVUwQTBkQVdPaEFkVDFqWXdiSXpkVVg4Wmhv?=
 =?utf-8?B?dng5RkhYdXBuQkUydGxGYmhXVkZBakljWkRDdDlVTTJUcFpJTW5UekJ6VkhH?=
 =?utf-8?B?dFlzeWo0L3VKVXU4dmV5ZHNkNmx1TzAranl5cHpDcitOZEo2M043cnNUdGx6?=
 =?utf-8?B?NUI3VmRYRXBVYnJybjE2d0Q1SkJPekJkazhDSStmamJaSlc5QU9pSmJVTXpa?=
 =?utf-8?B?eEpRU2RPSStpVUcwcExTWk1aaE15NW44QWgrNVVsV0xLaXB6K2FaOVdGYXB0?=
 =?utf-8?B?QjJMcnhhaFJTNmVBN1IvcUUyQWdYTExNVVpnVHAyaUt0aHM3OS9nVGtoeG9K?=
 =?utf-8?B?UzlGNldOdWVSM0dWcjBzR3NLM2hyRDFkZk1zaFozV3I5NWlTUUhpNjZPR3NS?=
 =?utf-8?B?V0tGdFJWZmpoNmlHTnlHMEhLQ1E3S2ZjVXF6TW1qMnhtL1dtaGVnVkp3R1pX?=
 =?utf-8?B?NEptVW9CNjFxTVNMZzZ2SzZSRVZ2aFhOS3NYTmRaOFUyUDNYMUZFTitidjRz?=
 =?utf-8?B?U25vV2JFYzVIaGduY1k3dWw3M3Q2S2w4MGl0blZEYUpmS2FrMFlVYzlVWGJv?=
 =?utf-8?B?b3dvcFFkQTZvREl3K3FhZWhqczJpOVRmWElFTERpUE5RRFZhMi90TUhTYXhM?=
 =?utf-8?B?TmNOQWZhM1A4OWJObjVUUWJjdjh0WHUvbWNtUkhOQ2IrRTRWRVp2UUNRanlE?=
 =?utf-8?B?MlZ5R284RnNUK2RQL05tWUkweE90WEFUYzNqVERabzE3UVBVbXlMVThyaEh5?=
 =?utf-8?B?TkxDa3ZYZzV6dUgzOVBPMTB6Z1BWYjBVV2Fnb2c4dlk4S3NDVy9TZnFHclFE?=
 =?utf-8?B?Z1BVZjMzanpLeHJNZS84ejgrbW9pZ3huT1NPa1RCNDkxejNFaVkrSzRaRUFV?=
 =?utf-8?B?UlRsUlNRQkNTdHpnckR6SGpKTVRQZkd2SE5HQUdJY0VKTWV3cEFyNUNSZVhl?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nu4a2vxBbKrw5GO3jdKt+M7hRZM5e/RKEb4IofpHUjqUZ2C7yHbin9udTcvSvlStKJBaqYPb0MuTIeW6B3faH2JymezGD2ymaS5fkEbj6V9Ck0ZxGByNAiK1354n+rkAUZIU6M4EnNlSgoBSe5/+4XCktVXwMJbo9PVTSyRqWgFCehg0ER0nC+MaoiYpEIBWffMqwdkIegjLLbykEHck/QfJRT5ScsUwz6xXA0xS1zwVH6UvW/wU3WbVlZ7M2XO3Hmezw3RUiGT5iaClCdjmIGw6DNFvXbg+YYOkIUOtvcfWsgo8DwiuE0zzLspp9PV4sQs7v/2eqETDqTzkqtMibs9no0fctsp8GjdlG19snXfqbmLvlELVyMWfIWWYyAgXIeIHQKF2hWE8Q0eJq0aYp99N93e7N9fjl77FgX3tj7SvXIYZe86jRZUX5eU5gNuwpCFNhllhilqfVVenn6dOqN1PxoN+jnvh9y1neSQTLs3+m7ykeRor2iqNQ1hy2p6jJdWApipR60OzJaI8REOqyeujYYqDMW83E32WnjTuFJC97ne9sfdBnzVpf7oVS2RpjHbtcL2al4ytSnHKJSV/jGTG9EpO+t1hle1QHkYbSjY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd0cda4-8b22-46c7-397c-08dd899522c8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 16:19:38.9319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOmjrI5P+vGrgabSSYoAQOzVkeoLiI6hI8I3wtJ8Q+QA9D4Bvw+so70ovLISH6NQ2ZWxkkMFiYdxBMmwFwlVfP8rJ30hScFfU+w8UdRIWBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020130
X-Authority-Analysis: v=2.4 cv=MIZgmNZl c=1 sm=1 tr=0 ts=6814f0a2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=fP0yDfHZq_0ui2O1LNEA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13130
X-Proofpoint-GUID: GP4ffw6LT0QPriUmDQxB-Gnjsgfzjzxl
X-Proofpoint-ORIG-GUID: GP4ffw6LT0QPriUmDQxB-Gnjsgfzjzxl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDEzMCBTYWx0ZWRfXynG3R6X9oc+j
 kZ1ftZUNHhFwpbywI4VEGyX29D8Bh+Y0bqfVF11PoEyYa/SK9iLO9jgqxHIV3xATqrRfZlYtSE6
 osyq86c17BkW4AHJGw4PhPiLDGvZ6GBgM4GtvRFwmTcMFrw+To7Iksx3dJkD0G1tac7zsg1jI3C
 dAqsjnN2/G/Cbxcqpc006of0hpH/f2+5oIP6SfyDt9K6Lo8LLUVnUiCzLH0zotgrYhAsa6xY0Sn
 MhjaN48eRhy8hYT8miCSMmFxHEfPuAJFcMUScbMS8AygTJbMcCG6eDAjaENiuwhljBGv5qcj8k+
 hyKxgInbtdxdPJ68A6XZUhbw+xAOOncuEYBB5BJkX/MuffnPqzX90M8W8mlMjLKeOGjdg5x8djM
 0dHBi1c9aBl6hxleV940aKviWDaZaVTx+7YPICg3rnKzrLuMHXjxs2oPFrqST9miqDaoIsYh
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/29/2025 2:02 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 4/28/2025 4:04 AM, Markus Armbruster wrote:
>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> On 4/9/2025 3:39 AM, Markus Armbruster wrote:
>>>>> Hi Steve, I apologize for the slow response.
>>>>>
>>>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>>>
>>>>>> Using qom-list and qom-get to get all the nodes and property values in a
>>>>>> QOM tree can take multiple seconds because it requires 1000's of individual
>>>>>> QOM requests.  Some managers fetch the entire tree or a large subset
>>>>>> of it when starting a new VM, and this cost is a substantial fraction of
>>>>>> start up time.
>>>>>
>>>>> "Some managers"... could you name one?
>>>>
>>>> My personal experience is with Oracle's OCI, but likely others could benefit.
>>>
>>> Elsewhere in this thread, we examined libvirt's use qom-get.  Its use of
>>> qom-get is also noticably slow, and your work could speed it up.
>>> However, most of its use is for working around QMP interface
>>> shortcomings around probing CPU flags.  Addressing these would help it
>>> even more.
>>>
>>> This makes me wonder what questions Oracle's OCI answers with the help
>>> of qom-get.  Can you briefly describe them?
>>>
>>> Even if OCI would likewise be helped more by better QMP queries, your
>>> fast qom tree get work might still be useful.
>>
>> We already optimized our queries as a first step, but what remains is still
>> significant, which is why I submitted this RFE.
> 
> I understand your motivation.  I'd like to learn more on what OCI
> actually needs from QMP, to be able to better serve it and potentially
> other management applications.

OCI uses qemu as the single source of truth during hot plug operations,
comparing what is actually there to what the user desires, and as such
must request many nodes and their properties from qemu.

Regarding being potentially useful to other management applications, my
proposed interface is quite general and easy to use, and I don't believe
we will improve it by examining more use cases in detail.  I'd appreciate
it if we could continue reviewing the code.  I made a concerted effort to dot
all the i's and cross all the t's, based on what you look for in our past
discussions of other patches.

- Steve


