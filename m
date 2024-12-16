Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD154E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNEwE-0002de-Ul; Mon, 16 Dec 2024 12:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tNEw3-0002Tx-M1; Mon, 16 Dec 2024 12:31:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tNEvy-0002fn-K7; Mon, 16 Dec 2024 12:31:11 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQjLn017668;
 Mon, 16 Dec 2024 17:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=9cQp9BPYiFSaAROTNU9Nm+z7GjpYVv+7Z9yozPQhydg=; b=
 oQrs04Zv0utOkIC5rSZTc2mevCZzsPCXCLRcnkFFm+r7yy2WUBx0clor/YvgOgJM
 uahlEtZ+gLlFdIhEYjyjM9ZjHOs6KUVk+NQY9g4HVOuBwqt4x1S0UkISZmyF0Dst
 IcIUcMuV2To8gqtIrzEzM3KULUdYNmTNxiynqQEfcrfQQj5r4voGz7aVwmkRbYhv
 WuDmBrRTfze5Qbi1irVHqwoWMGMCoP7yj3BWepnRPaARCG3XMWZ9V2Hq28ZztAC0
 R0gcxA3IYj26QWthIxmTmh11RharmaLxy8/l9fSjIr9sBb4zearUJvAPIaVAeUzz
 cxOdFQDbVfhurVqxhasMsA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22ckuk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 17:31:02 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGH034Q006411; Mon, 16 Dec 2024 17:31:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f8a81h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 17:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPb7b8MZaLsIgGGu9+m9z+iwMgqb+CGkIlNMIByi5CRys8iUjiRIWeCqbk7/fufBB7aPo+hBA1Dqa+zV0P9ANsV3hDiBa92+rJQbViO9kM1PFRh3N3reH272yj0xrtBJ18fGVR/AQ7npcjR2rDmMLtxtXIA4nSP5aln74iykKiuV6Z45s6SelbwH6X4oHtGcBd46CBzQs9pf1LqjAcf47D5OFlzWGbb3SCJ4o6UnyGwDrNNEK2wJIJGqkHp85phPrRBQWOWcRBoVUNcrQwBB78Lmt59PZyVfEvPS7gG63W8XrmnRdetUspQL8PShfBqqMVU91IBXDawtaC1oUhvioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cQp9BPYiFSaAROTNU9Nm+z7GjpYVv+7Z9yozPQhydg=;
 b=iZFYxELq1xgDlSBADvPqrvA+bGz4mqcePVISIDRFNnQrqO6evf5Fo5agzizDoUn6O7p9I8kD3yfk8CRzfB9i/X3BTqNbB/bzbhQVNen3B5kVXqVONxWpWGunSPZnjwXV4n36xNtiDRTPqAR5dC48S9HnMhdFcL6ri3VdS437U5D4oF37rHN/MDilnQWXNH4FZMGjgdVlqG006y1j+siG5ixcE1firqgYm/myI6xT2znLc7J1vpQS9nVu3QYvUnlYMKbSzFRydHAFJ7c9EqDmOGDbdiuI/JovcGL+I787BFlRHok+LuGHns88y8kTrr4QHqKFxhNeq02JCw7CxunBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cQp9BPYiFSaAROTNU9Nm+z7GjpYVv+7Z9yozPQhydg=;
 b=DrQe3S68/Nvu7BCVk/jy1Nm0dkwUu914GTn/DlxAdBS926JeSoWJcv+6/2k+UZmcTyLJflSI4mb7lvOI3MFVY14h/Q54BIZ5NwQ1CvGJt7XbLjZSRnFQAVIpoldiM6uE9gA07hqPfmKI3LgVttLIQKaCgCYNlpRMCZ6i8efPZkM=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by PH0PR10MB7080.namprd10.prod.outlook.com (2603:10b6:510:28c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 17:30:59 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 17:30:59 +0000
Message-ID: <c9341f03-ecc2-4a62-860a-35ff2b660651@oracle.com>
Date: Mon, 16 Dec 2024 12:30:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmp: update vhost-user protocol feature maps
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-trivial@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, aesteve@redhat.com,
 hreitz@redhat.com
References: <20241216170914.1346403-1-lvivier@redhat.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <20241216170914.1346403-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:208:23b::21) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|PH0PR10MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 26748b03-f0c9-4901-0af8-08dd1df767d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1FYVWtzTDFGb1pTVTh0NGlyb3JJd1Z0MFVWaTZDUGlIT0I3dXFGU1NxVmFt?=
 =?utf-8?B?MmJCa054TEQra1E5WmpCQjJRZnVWTUxQbUFrc3dlUWNGR3F1VmZ6L3puOHpO?=
 =?utf-8?B?ZDNsZERyL0N6OUliUHFTWC9wMHdXbjNJMW5VZUh0TVU1WHFsaFRJRmpuczN4?=
 =?utf-8?B?VlJRQ3ZWRm9RUjFKZUxoeVRRL3lPYkJzVDVlSHp2ZVdOU0IxTlNiakdKTCtM?=
 =?utf-8?B?b3hlTUp6Qkx2MUk0ZEZWY0ZTejNTa1oyeDlvN0RNZXNtd3IrU1QwWlFHYWxP?=
 =?utf-8?B?cGpWVnNXZW8xVFNrOGUxNjd5VTE2eUJOSEJEQkVTMCtncnVsK2dWQTlCamhn?=
 =?utf-8?B?VlovUDJpZWZDa21wMDdaWkRBQ3lNNzlybGp4ZzBETGdEOFp4ZlJUT1hPVlh4?=
 =?utf-8?B?MGlJbng1K3cxT3RUREVON0l3VkowUHJMamdsVGZFK0dET1MzeXhVajJPTDRT?=
 =?utf-8?B?WGtaTzRaWUJjTG1FUEFUcDZCQWY0QitzY1pPaDgzNFZWQ3lybVdtRTE0Z0gx?=
 =?utf-8?B?ckpYVUJZNUc0bUxobUJHZTRGS2p6b3hJOE9PbmdIR3M3RnlQa1ZHL2JJSHI4?=
 =?utf-8?B?b0kwWGJkaENYcDEvLzBYVzFnUjJHZnhkeFRiN2hHb0VQNFo1QVhDKzJITlBE?=
 =?utf-8?B?SkMxUmJpL25lVDlOcjBpcXNDbTJjMkI0SnkzQ1ZQeXdEQ2RLOThoekVtd2VR?=
 =?utf-8?B?UnIyWmg2WmROdFlobFVTMVdJTERrYy9yUGhSbW8waFppSDRxU0ltOW15NzNY?=
 =?utf-8?B?T1NxN29lR1JFdk40cXZrS0JtL3JlOGorQ09UaFk2cFZSbjNXYTdXVnlNVFp0?=
 =?utf-8?B?VzFnNWZZSHdjaGh5QkNGUm5Nc1BsWkROMEdvTml1VGlCK1B0ZDNkOHRKZ01I?=
 =?utf-8?B?cENYKzdqcHluSkFKN0FTWC91bjRTS1JvYkRKbVBRMDFmRVNnbnV2S2dDcGtQ?=
 =?utf-8?B?em0zKzVVaTl0REdhU3NGL0pEWHg4Sngzcm1pZTRrTEpBK042K2M3SUN0VHhV?=
 =?utf-8?B?c2llK3hDUzV5blZ1RkNrbnJ6R2FqNWlLWHdNbHNiYkM0cTdtZGJmYXkydm11?=
 =?utf-8?B?bEF2dnlGMXpqUzJibkFFT2dZRThFcjFrOXVKSFpJME80Z0tVVWFFYWZYNytT?=
 =?utf-8?B?UmE4L3VyNlN5VzFiMFZHQUVKdGxqMzI2ZklkWllyVW9DUVJCbVAyNVg0UEdz?=
 =?utf-8?B?UEw5U2pQdzBxYkl0ZDRxeVdJdzk3Wlh4Y2pOL3RwR1RiaWYzZ3BUUnBFTlox?=
 =?utf-8?B?QzVFWUpTcmtrUkFMcW9lVWdhRGZOK05GZHV5ZDVwbEx6cXpZcDZwb1cvNHEv?=
 =?utf-8?B?U0JiREQrWGljM2VtTjBNZHBZOTFoMjJvNjZtVDVobEQwT0NpV2diYjc3ckZS?=
 =?utf-8?B?a0Y4QXZ1YkljRG95eDNiL1daaXBDWVhkYlcvcVdkRnhVSU12bTVpZTU2N2lN?=
 =?utf-8?B?Y0Y1dGZKa1EzYWlhSEx0ek91WW8zeVpiNVRtanA3K1AyMG5QRCtVNXNRZ1Az?=
 =?utf-8?B?Tk1WZ25VZmptekdEVnZqaVFpck5CZVIxV1dER1l1dFFleU83MnNRdFo1akZY?=
 =?utf-8?B?NEtpakhCQXRYeDFVTVRtWG04L2poSHdPZTNxb0hiVWp1eTUvbmZCQWVrTkYz?=
 =?utf-8?B?K09LcGUybXpsQTBoc1c3N2NVVUE2c3pHeW1MUUM4WXNWZWhDSWtzS1dPUmIz?=
 =?utf-8?B?VUREYVNPcmVVenJEVjRPSWlaU1lZYXFJZ0pHKzYyYURudVZrbU40MW15NE5E?=
 =?utf-8?B?M1RCUVZRbEc0YWhwRWJ6THdic2l4ZkgrWUlGN2Jqay8zcVFjRExVTVd4c2R6?=
 =?utf-8?B?Nm5mQS90a2xKaHJ0UTNZOEJJSEh0cDlZVHBRSThuQzEyd0RTRUJLVEQvNUZX?=
 =?utf-8?Q?TmkNp9KRntYAQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5TQ3FlZkdTWGJjOXQyREhtT3lRdThpOFdxRHRZM2VhSjc1blJtdjNQek1K?=
 =?utf-8?B?SldDSC9CS0RVR1hLNU9xZXllZmtpVE81WXdaaitRTGU4eG1hZlZzOS9mbGJz?=
 =?utf-8?B?YzQ0cUdaTlI3b0FNUGU2KzcvWUEzbWFZMVpaQWZCM0lXQ25qVUhVbEduTHJT?=
 =?utf-8?B?K0U1TVJFTEJScEp3Z1BKZFRMK0hXNVMrU1VuVWJUU2h2NGUrZ2VpYmZwYUdl?=
 =?utf-8?B?ZmNZTG9ueTdlOFQ3T0c2MnFqamw5VWZxbTkzMVZicENFZXd1MEpJOXhJWlpH?=
 =?utf-8?B?cFpEbjlNb2NTR01OZGtrS2xna1JWK0ZScVd4VWtuNGxPb1ZQOVRXSmRvL2dY?=
 =?utf-8?B?Yi94dDJkQ2dHYi9mb2tpQ0JNK0JmM0RRYTA2NUwyMnlzYkRNTFZCUG5mZTVK?=
 =?utf-8?B?VEIzNTBpMzlHNER4cmZFUW9hUUY5QTkzZ3dSRnJzR1N5T1NIZW82OXlDK1JI?=
 =?utf-8?B?UVVkaHB5em5USlo1S1pHaG5xTTFsRHBPWkIwNnVCWFIvQWxHQ1l5eWtoNlVI?=
 =?utf-8?B?cjJna2haYTBSYVJ6VWZIM1hJczJUcEk3REs2RnMySWhNYVpQZVQreHNkRnJw?=
 =?utf-8?B?T1dwUGZnbVJqaTJBaWdCMThyaVMrNEJaenBseFFkRmREZFhmOVVuOTZGT0lk?=
 =?utf-8?B?S0tDQ1ZaMFkyTHppUzVmMGEzd1IyU21ZTThUY1lVRkgxL3g2d0RXZU5aSXQ2?=
 =?utf-8?B?QVlwWmw5MFZsUU1wajF6N3ozNm5hT2JVc0JlQVJTakxHcC9DUkErRTBWMFB6?=
 =?utf-8?B?L21MMWZ4aVJKb0QvL1RwRlVGK0xKcVROZkovUlpiakIySld2UlVIeFpSUVls?=
 =?utf-8?B?UExHV3hkbFowdWduQm9jQnFIY0J1ZG1MZjVKc2dQZzJjRHhLNzNTTHAwSlE4?=
 =?utf-8?B?ZjNlekNUMmZrdm1ldXoyeVVWYldLZkxQaVMvUjBuMzdWczVuMGxKdy9tbS92?=
 =?utf-8?B?WTE1eUFFYjVtcCtmRHRJNVpzM2FXaU93MDg3MUR5RHo4RG9IVE1ydi96QXZY?=
 =?utf-8?B?TUgyai8wVUlKb0VqZWtmVTYzM214ZER4a0dNVHVMcUVKbUJSRTYrZTVHaDZ2?=
 =?utf-8?B?K0VwazRWRGpiUGl0dFhRQXNsL3ljVlRGTktpVTI1V01qTFpZcDNIQURoOVRH?=
 =?utf-8?B?WW43M1RCdE5FQkZ1RGgwdzhYT3o2ekttVHNPT1RJbEJYMEZCZWdUZy93cHN2?=
 =?utf-8?B?QUIvZTIvY1dOb1ltSzVRSHlFWkFKVGE5QWc3RDg2d2w3TENJWGIwQSt1Y3Rz?=
 =?utf-8?B?eVdWVmYwQ0d1WGtTcHkyd2htc214eTFKRWlkbWpaWlM1Y3pScnE4TDg2MDRP?=
 =?utf-8?B?MmgyUWNuSm44dFBYQ3Z2dHUzNGc1MDBaZDY5YVE4RVU0bzBSeWlNVVRWYWZT?=
 =?utf-8?B?UXpHQk9lZ2lUVFE1Mms0MkQxaTJpc1pITlAxZEI4NlV6NmdieVBQVVdkMlZR?=
 =?utf-8?B?SU1neFpKaU5PckRGN05yc1JvMkdKSm1zWGlLVnNCcEovdzRLL25tV2xoclp5?=
 =?utf-8?B?RjlROHlGRStVeGVVRmx6b2RkY0FqVExEQmJ2VFNJYjJaTWFuL3huYWx4cWdr?=
 =?utf-8?B?emNhZnk0anV6QzlUUTYrK0tBcFB0VTkweTdoUmNDSExBVGxSRjJ3cUFlZkJR?=
 =?utf-8?B?QWZyYkpPalVoeW5tTzBpSVRmY0lGYXYybVRuck5zak0zRjVTSC9oMVhkMHpM?=
 =?utf-8?B?OFJoQ1Z0Q2k1dm9SNlVNL010bnkxNmNTdkVxT0RaejFuR3VtVUVCSDN5VWxC?=
 =?utf-8?B?MFhBay8vdExydFRIYzJ3ZzBNOGJtSFprQnBxcTlkVXBZOW94MElrRmtpS2k0?=
 =?utf-8?B?MWNBMzNyOTlRbXYxdWNHT0M3RkIwUFVwVVdTclZQeXErc0VuN2cyOUNKNHAx?=
 =?utf-8?B?Vy9PTUx1RTFBVVF4MUg3Z3ZRYUN5QU96RUZJOGNxV09ibVBJTmFiWEd5eHlX?=
 =?utf-8?B?SkdkZDZmQlZRZFZZd05NSERka3JRUVJKcHJMMVR6MitjRExEOFBjZjNMSG5H?=
 =?utf-8?B?aVA4NnVuWlMzdU01azZWQWIvQWp1cmJhclNQQkVucTYwVlZrSjg5OE9hZFF2?=
 =?utf-8?B?VFhPT25jbzJwMm9wYjlpMEl2TUozZit5bHhSWktuMk1GQ2YrL2VHd3VPbWJW?=
 =?utf-8?B?dWZFSWZ1K2JReG1BWVNXOWt5ZlJBZEJLOEN6Zzdod2xOVlJDTFVtZmltdXpE?=
 =?utf-8?Q?wuk1SPjJ42YRfkeg1KFba7A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Nzidzl6v2Y5Plu19hvCrRDEqIDtdOK1jVfB55RsdawiyRsEZQ/3hcN0uW40rjAPegzBlTf/1GeftNCBRJjDZOaZndWhLoyXey6E0HmbfQC1aIrjMw0cU7kMZelXKIKWjDk2/akXF7pw5q8eZ3sb4Zg/BQTytY2HOGlwoIE909xahgYhHSSQSukrCk2e1TP4EADhIFeX//ba4d52CdlPwv6QWBTHEpBXbWdT9uIY2Zi0ZD39osUKD25EYLLG+p7etR8uNKayuuv8izYToOT7aden2GmI2qjsZ1p1nJ0FrkZIljx22F7FbDY6T7CWFn3BkvjUZ5/SE2ABccqOd2gNqv1tJOQQyc3U/rWPqxbLLuUEWJrBNJCptxfm39T2vxqOtIAWCreBKWgeVk0LhRFaz//ufiLI4rvhYTqZiYduNcIK+2fbD5F4w+MxUxQKxE/ElvVzQksJiwjyjtYhjG9ddL6BMjYKzxo1aQW+/iP/JfuCcZ17XhWdlenRWX5I4XwGpUClHQwmNsU5tOz2TN2dY5rONEeHuPIr40TzynJH6zO5Mv5VUohbeAtRAfg1y0LEj3u19vS90IYlzvfnRYUNqmLEDRClx0nVAE4QA5iCgtT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26748b03-f0c9-4901-0af8-08dd1df767d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:30:59.6126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tGeOizPmBgLbMs3rjIba9Mvwsj7asZTC2PYkHFPPyTlp5D3jPsAaBrACoGPprYjxe7lUlqOZCxBWygmic1b6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_07,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160146
X-Proofpoint-GUID: za4mJ88AVmFVpO4kd6ASmNfzIq0AI962
X-Proofpoint-ORIG-GUID: za4mJ88AVmFVpO4kd6ASmNfzIq0AI962
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 12/16/24 12:09 PM, Laurent Vivier wrote:
> Add VHOST_USER_PROTOCOL_F_SHARED_OBJECT and
> VHOST_USER_PROTOCOL_F_DEVICE_STATE protocol feature maps to
> the virtio introspection.
> 
> Cc: jonah.palmer@oracle.com
> Fixes: 160947666276 ("vhost-user: add shared_object msg")
> Cc: aesteve@redhat.com
> Fixes: cda83adc62b6 ("vhost-user: Interface for migration state transfer")
> Cc: hreitz@redhat.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/virtio/virtio-qmp.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index cccc6fe76183..8a32a3b1052c 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -121,6 +121,12 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
>       FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_STATUS, \
>               "VHOST_USER_PROTOCOL_F_STATUS: Querying and notifying back-end "
>               "device status supported"),
> +    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_SHARED_OBJECT, \
> +            "VHOST_USER_PROTOCOL_F_SHARED_OBJECT: Backend shared object "
> +            "supported"),
> +    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_DEVICE_STATE, \
> +            "VHOST_USER_PROTOCOL_F_DEVICE_STATE: Backend device state transfer "
> +            "supported"),
>       { -1, "" }
>   };
>   
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
Jonah


