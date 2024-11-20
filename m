Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10DBD711BF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 16:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDnKF-000314-RM; Wed, 20 Nov 2024 11:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tDnKE-00030n-Fy
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 11:13:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tDnKB-0000WQ-Dq
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 11:13:06 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKFtYFm001527;
 Wed, 20 Nov 2024 16:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=gQ43PyGQEATnw6eMrf++uxegOdTMCMBA24Rz+qwI0Q4=; b=
 kUhgWVWFeRotk6hFNMAykPo74oQD2a9CsfKQw1XwEygKGHahvvHMfjNT3WEQTCzv
 xZ4NGPQRbI7nKoX4yzM8v6ITjDu9lvBAtZ/XRzYlVwYmNDSLFusiBTsc/DgnDcc3
 o/+RfRNJ1CAFKJv9NIANu5wyC8KVYBmLw4TI5MYYBVVVUU4Lvj5Qe3qCr9kTrl7C
 dDrfvqKWLiegaY0kaV5Je7CMrpPZI1klCcL1PYubWBcn6l8ovXksIdkI4M3G4jsr
 13loLsP9mNzjgKliX5nfAxBpGL6dpmYfrr1bxSJJf/Cgt7XxcBO3Z55cvP7aiN5e
 IYbvYSP7O6ptul6SvsDEKw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkebythf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2024 16:12:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4AKF39BV037395; Wed, 20 Nov 2024 16:12:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42xhuagrrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2024 16:12:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0RG3ZgsCEWpRbHYbhbqDSjsTWx2VfKGfmszOX1Xkgu6ZtnN70QYlzXvInjPbghwogkHzhFoHtACN4oDrepM2EgO2zQhFcBsEJ17tqUTo8x8YH8G7430bm5ga9HoihOcRE3YEgfY2yfVXbhYng7wt8aT7UejeWy2+zfyzTL5LSC5JXTuO7gmo03JKv03zF9zO1Cv9Zqk7HNvjOi2SNuKyjlmd1fjvfLBvJDAm9tcdCvqxNzCigIQu7oHL16hhM8dyLpOHnMc0x4zJfq7y/eli8cy/C1IHa6jPfot/7vm9P2LcgoPmuL1rsgUKiedf4VDsnq+0UwzmDocpGGF8Db9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ43PyGQEATnw6eMrf++uxegOdTMCMBA24Rz+qwI0Q4=;
 b=oymf7eo+vEURJikD2Ivee76PlZ8ZVEn7Y2h4tdRhHru42hp9hAH3wQj6OJao3klfdvbnUJoA24YQu29jBolw60cSVpCA9zt7dYcsIw5Ea4nQhI02H+uJ3d3I3AolQ9bJA7AEIxkLdVqaxcj7bZ5JIGr3HJoue5YBMwLDNNxyMq06FkwQytsvZ6RbpgcQ4GC5bk1b/fiD8bbdqYTDcd4qLUj6XxIzFWmusgVzBLuK0Bt8leaUPcSYN3HwvebzBbbe1pAXw+NYSuDGRcIXt6l6AWFYLBT/zRkXh5GxeN6Y/DnpEpRXOmCFXV8vl5jb9iMo0H6Z7Z44wNYmcAfRpzVO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ43PyGQEATnw6eMrf++uxegOdTMCMBA24Rz+qwI0Q4=;
 b=SOYuYxpxnv+GZKYgN8X3ywdpbvqwDJukjmViOXkV8pH54B+cF4/zzGiNXZxTIvtEX8FPeiRyjDBdnsIAlCn15bcZuGSrR5U8vVMyknR6BSgaFXUotDiZpILQJSWG7n1g9l0usTEG6ag/nOtCXkRHxjjJOwY3zkYs8V+a9QH1l84=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 16:12:54 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 16:12:54 +0000
Message-ID: <fc5397de-8955-452e-87da-c5887e7f690d@oracle.com>
Date: Wed, 20 Nov 2024 11:12:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/16] migration: cpr-transfer mode
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-12-git-send-email-steven.sistare@oracle.com>
 <ZzUg9w0Kvfuleuxk@x1n> <51967cb2-05ec-485b-a639-8ff58d565604@oracle.com>
 <ZzZJvTldpe3D4EO5@x1n> <c53feba3-d448-4494-8dbf-0725a2dd8dba@oracle.com>
 <ZzzyOJT_mDh37_Py@x1n> <c56ffc81-b065-4dd0-ab06-eb79912dcaf7@oracle.com>
 <Zz2uAWLAhaf2TQ01@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Zz2uAWLAhaf2TQ01@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:408:e1::23) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BY5PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fd7f7a-140a-41a3-4e6e-08dd097e30c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHlvYkZXcFRKRGRJSEJoK3gzTXdIVUNkNHUzWWlrWDJVQm01NnN0WWF4Tnh5?=
 =?utf-8?B?cnZsdXI3QzZFSUdwL1A1YVI4YXNKNW9ud29vekZwV0xxTnIyZmxRK2FRRTRV?=
 =?utf-8?B?Zjl5TlREekc4cVJSUmxINXJzcWRPSmgycVZOa2NvZDI5U3RhRDlMV3MrckhK?=
 =?utf-8?B?UGtHQU5MQkswVFRjSW5vNy9NTi9Cb0NhVUZaUFVwSTdGM1c2dGRTOVRxc3VJ?=
 =?utf-8?B?RHltMDcrb3A1TVdPK0FIci9nS29CYlNwYzBETXZQaWZuZS95OFU5eitGVGN6?=
 =?utf-8?B?UnRETmVDcmpsNCsxVGZObElHN3h0VkNldS9aOE9qb29FTTFvR1BlMk5tRlow?=
 =?utf-8?B?Si9DeVlVdmNPOVNnaDduWFdEeGV4cWVhRmNWUExMRWNkTG1zM2NPQTVwWFkr?=
 =?utf-8?B?eDlJUXVrZ3ZDSE4zZXhGM202cnZDOEJIT0dUNlNPRTVUQ0tLWUNlTUk5WUlj?=
 =?utf-8?B?enBsL3B5YU1IQjJVSEszTnBsblNMTXlaRUY0azIzcFlKaU1INnFWQmorRmIz?=
 =?utf-8?B?blRBM0JLL0c0N0VuUDVLQVIwNkRQY1F5Q3I3K09WVWFlMENRSWFZWVBTTm5t?=
 =?utf-8?B?S0lsS3VHMzZQK2pJbGRnQmlRTWNaSnJ2UzBnSmZvWE9qTzdDQkc0ZFVDODM4?=
 =?utf-8?B?RWg4WFBtNnVWTTlRSTNCdkhrWVRubVhJcHp6RVhrb3VXZ3B3aDJwVFdsWmxJ?=
 =?utf-8?B?eWI0M2ltWWhqbXdYamlsZDNyR0w4azhJdWEvWE9xc1QzZUhkRUVNMDhhTHlM?=
 =?utf-8?B?TDNZTFBiOVE0WUJFWk9sT1ZHbVJiM0dBTk90c2x4RUtTSFlPUkZPVkFvMzFZ?=
 =?utf-8?B?czBNWVFBR1Y2MFdENTNHVmZ1c0hFb2FNZW94NmEvNmhaQ1BWd2xtVmcvdFVE?=
 =?utf-8?B?ODZHRkgwNS80OFNRYXp1S3dxeFJaakp6Wk9vSnJ4UkYrNzN4UDJmNVFLVXJS?=
 =?utf-8?B?Y29aa2pIbWhMa2NEVDVSSmZNL3NZQ25TaWQ4Z2l6TFZPQUxWTG0veXNBLzJZ?=
 =?utf-8?B?MzNSNkNhdG1xK05YQldpNzVFRXhNUE5oUWRFRUVBTm54TWZWbDE4MkE1MFlG?=
 =?utf-8?B?aC81YjFIbjduZVF1QVQySTQ1ZmV3SkQwY1JIeVJpdnJyWkRLNUhLb0M1c2F3?=
 =?utf-8?B?WlN6M2s2QVpMRTBaSHBwWkdvOXhFNUdlWmRSS090VWR5VTlZdHJxVGNrclVL?=
 =?utf-8?B?T1dDaklYR0s3Q0lNek41K2tjQThhYWRpYVkreTVFNjlTVG82dmR0SDVEek9y?=
 =?utf-8?B?TVNHWWtnNndIbXlYOTRMSUhTQXFHZDZpZlJZV0g2N3I3bDBDVUpyWU9HVEtu?=
 =?utf-8?B?aE1xdEEvMFRRbkF1dWZhVFBlczNuWEZtV2JKb2luNHdPa0dqWlBlR3NieU9o?=
 =?utf-8?B?dTcwVFY4bVZ3WTdrdDNad2hFcWFlamVjL05OSnR6VGVhRWdZb0JRa3lGNVRI?=
 =?utf-8?B?K01OL09wVzN5N08wajU4djFUTTdQRGhkNUU4NDJFWmt4Y2ZHMlpGSTczdk90?=
 =?utf-8?B?NHRaNUxobWVTWlFHQ1MxNWFhWUNEUG5XdmRtRFJ2OWx6RWlmM3FWNGI2R2xE?=
 =?utf-8?B?Q3Z4NzZwV0hSM0c2bnRnbEVHK0ljOXY0NkVkRE1pbU5rc3FwVFpiV2dUZ1Zt?=
 =?utf-8?B?MkxhZ2dBSWR0WXJIYlhxNmxkNXhqc2hzYzhGQkFwS0NiS2NOR2Q0WmhoajM2?=
 =?utf-8?B?akpibmdBdEttemM3YStQM1Q2Z3pwbkdDVVlPc0o2K0x2amE4NmRLWC9rc3gv?=
 =?utf-8?Q?i8u4J+TurX8cKhGlASvPRKbmbJRU1C4jJrLcPpc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFI0bzdQaXM3eEQ2TTZWc1BDdXByOHR1OGNEeFdERDhjZW1JQmVQWTBLbit6?=
 =?utf-8?B?b1RValArK09zb3JGTkNGTi9hMWlKNU1oMzU0aHlOdDVobzdOdnB2SU1ka05t?=
 =?utf-8?B?UEpVazJNM0hWWDlqeUVoT2V6b3JmcjlkbFY2bGszeE50TXVvenRtMHZPMGxl?=
 =?utf-8?B?YXZnY2xFRTJ1UG1WVTF6N0hzeHBhR3VQQ1QzamVaOGtScHR2aXpVMnRjczFj?=
 =?utf-8?B?TzhDVXFkT3U4eng5MHN4TkVvVWVvdTYwWkhGSU96Uysva1BHcmJYZmpIb3ZE?=
 =?utf-8?B?YkQzV0g3eFBLckVBOWhYVUdCS3JLenB4M1F5UldER3ludGI3VFZ2Zlg3ZnpX?=
 =?utf-8?B?M2Rwb3A4cFk4QTUxeTBLbXBlZXJPWWE0cndBTVp6YnVaeGdpV3RrdDJBN2p2?=
 =?utf-8?B?L1B0ZXRVTER4WG0zaXJHeU8vRWxlM29vVXFJa3lINUhSUlMvVjFoU0kyVHl5?=
 =?utf-8?B?WitwRkhGNGNZbjU3eWpCdmppUDVkcDNlOE54bnk1MXBvYklZQVduNnB6UzQ3?=
 =?utf-8?B?WWRoNTlzODZ4ZHRmczZFMngzRXlKelhjVmVuM01UTTFJWmFvcytjQU5JM3Rm?=
 =?utf-8?B?OEgrMFJrR0dkUGRLWTNLVlR5ZXkxR0RHUWJ0eXhqV25ib29MKzRpQjc5eiti?=
 =?utf-8?B?bm5RR011K21oQmV4dmlibW9tTWRTZVJacUVHYmp6RDhSVE96b05IVXVROTBj?=
 =?utf-8?B?SXdiZzlJbkx4SExCYTdoL01tejduSDNKYjAyREQwRzZ6UTNtdnZjWHF1V3Y2?=
 =?utf-8?B?UEFVZDNjWG9JeUpyNXE4dm5Hb2M5b0tiZ3AxMStMZW5zQzlPcDdPNnp4TUlu?=
 =?utf-8?B?THptek1Jb3IvbEtuWEZsU1NTTm9SZ0c1K0EyZkpQbzFkUEVQQXI2bnJjSWhu?=
 =?utf-8?B?K1NiUThCeFM1aVQ1L0M5d1BzZ0xaZVNKTzRoZjQzRGd5bm8zTzFjclZCU0Uz?=
 =?utf-8?B?MEx0bGRoeE9nZTV5RFlFeTNBYWVyWkVTRWdIeDhjZjNSY3FrcGprRlFFM1hY?=
 =?utf-8?B?R0hBNnk2QktrUlZYV21pY2RqR2J0Q0JPdUM1ZlgySWZJSjllVGsvc0NNYnRq?=
 =?utf-8?B?NllpYzFZRHQzQXluTjI5cDdpZWNCS21wZm5XaE9mWHpzVzBoOEZnVko4OFhP?=
 =?utf-8?B?ZlJaSXBlMXRWR0xrY1pnR3dKdnZtMGkxdmZ0ZktDeEVIS0dEeUMzSVc5NDQ5?=
 =?utf-8?B?bE1ZZk5JOGtGZXVJL1Fhbk40SWVkOHppeGdzS1VxdzVhM0J2blZtT0hqbDN2?=
 =?utf-8?B?QTV1SGJxYU1uaHdrTlZFcm83bE5PTWxyVVgxNkpNNVpRZlpmcC9XUllFSkE5?=
 =?utf-8?B?Q1U1Tkk3SmRMbGRCMTZrb3pDM2JhZ0JXaVBFdm1aUnNmejlsWWluOUR1LzJp?=
 =?utf-8?B?V205OHkvelZQeE5uRFVpa1YraEY0RDdteHV5MkM3U09BUDJXUFVtM3JmYUhs?=
 =?utf-8?B?bGpSSlpPYXVkVDc2N2NUT2N1QUhhTHNxeDduWU51NlFRTzJiMDcvd3BhanRC?=
 =?utf-8?B?cnhZQ1phWDBOQ3o1MS85bGhiVEh1SzRremJGcm9GYmNXNWd0ZzNqRit5QWM0?=
 =?utf-8?B?UVBZM1ZHK1FjMFJka3llMnN1eEZYd3o4eTJzNG5ZYkxpdjVKczFKSFBGeGN0?=
 =?utf-8?B?MEZWaUtSaXFtUWRHVFNrVmZBSjFTQS9vUkRzWFc3L1lqK3VaVkw1cU9vUElL?=
 =?utf-8?B?a0xzeU9INzFkK3dxcEZMVW1RQVpTNG1CZDJuK1Bkb0xvV0syajJ0OHBocUVn?=
 =?utf-8?B?aGZtMjhtN3k1ZmhxdVlwY0NOSW0yS003eGl1THIzRExPbWVHWkVGbFRHck1F?=
 =?utf-8?B?UHdDZXgrYW9HMFZiWnBINDk2SHYzYzFwMjhWTWl0YVlYY2Nnckp6SG12Slhu?=
 =?utf-8?B?NzNXNUhFUjFDU05qZHBsK3pzbHhJQXp0cW1LZnhCVlRqc2hxcGN4NldacEd3?=
 =?utf-8?B?QVdReXd1RFRKM1MzdXVHbVE4Q1ZzMjgzL3lLcGp5YnQ2Q0kxL2VNenQrSmpE?=
 =?utf-8?B?WE5YUm9EZzVHcmNhS0J1VU0yM2h1NjJidWxCZ09PcDJMZG1ETytCV3kvdFl3?=
 =?utf-8?B?N1dWS1hWeVU0YTBnT0ZXUHRReFJVYmdacmJWZWJCT2NvT2xLZjNaalZhTEpD?=
 =?utf-8?B?eFZrTWtRbW9qWmFYUy92UForRndmWHZldG5SWm1jaDFDQWRka2ZuU0UydTRk?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JNPxBWy5D6uIAgui0zs/xteSDU2JkP5cUSVXF89n4Be4x8U2dSc/+z3sIPqZeLLFWlmgufBOLTDHKt9i0cU2o6c4/VaedM8I5j4fJB7C/qwF7hul3l19hYyzwD3eCOCDXFP7Eye/KZ7HvyOta7NoWuHnmCsmdenX/k6apn62xTAjmin8/o6mssQCEcyjXJky2LdcEPyVcoBTzbyMFkDAGuYXnXoxRtzbHu6y23H+M4dxV+V8RVVmgsLw+szRhMJe84cvnkUla383Gy0aBCQPZpfRqbpPFR1DyMwIsbh6L5YvI7mFGcJatI77VJ/J/NusNm++oIzhb7YQ9GIdM/r5mq8q6JLsn24ObboazgXM5/8ROb0RDsJFF1WM+tOMjSVeLsDNTe4V9mejyXRGXiVlEcw7lhlgCUj2FmJsgKbINAv5p34Hj47aQmaKX6gx6Qo+ibtOR66TLC4vFelwI6zmT2tSP8D5cneAJhCtzIB4IopWNT5h+Z5C8xwYnrrNBhC6DEnVHSIOtHgg5GX7cv3T2dTTvoGAyLyr3OmkAhRuF1n7vzPeU4EXx4r88VsaVxq1TvXNatBKzryP28/avAM57bTSrHoVV3vyPw7rk+R6rKw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fd7f7a-140a-41a3-4e6e-08dd097e30c1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 16:12:54.6604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNEWnEIjJQNqjRC4iOluW7XEYO+uzJBvPilnSAg6H2xVHhKU7+F/OpTDqhvPWk9u0+WKEve49iiqP8wWKjAnFWPwis7uTGhHVUsIQ/pe3T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_12,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411200110
X-Proofpoint-GUID: W5WtkwLOHG2LXAUjtzMtPPvOSCGx3b8G
X-Proofpoint-ORIG-GUID: W5WtkwLOHG2LXAUjtzMtPPvOSCGx3b8G
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/20/2024 4:38 AM, Daniel P. Berrangé wrote:
> On Tue, Nov 19, 2024 at 03:32:55PM -0500, Steven Sistare wrote:
>> On 11/19/2024 3:16 PM, Peter Xu wrote:
>>> On Tue, Nov 19, 2024 at 02:50:40PM -0500, Steven Sistare wrote:
>>>> On 11/14/2024 2:04 PM, Peter Xu wrote:
>>>>> On Thu, Nov 14, 2024 at 01:36:00PM -0500, Steven Sistare wrote:
>>>>>> On 11/13/2024 4:58 PM, Peter Xu wrote:
>>>>>>> On Fri, Nov 01, 2024 at 06:47:50AM -0700, Steve Sistare wrote:
>>>>>>>> Add the cpr-transfer migration mode.  Usage:
>>>>>>>>       qemu-system-$arch -machine anon-alloc=memfd ...
>>>>>>>>
>>>>>>>>       start new QEMU with "-incoming <uri-1> -cpr-uri <uri-2>"
>>>>>>>>
>>>>>>>>       Issue commands to old QEMU:
>>>>>>>>       migrate_set_parameter mode cpr-transfer
>>>>>>>>       migrate_set_parameter cpr-uri <uri-2>
>>>>>>>>       migrate -d <uri-1>
>>>>>>>
>>>>>>> QMP command "migrate" already allows taking MigrationChannel lists, cpr can
>>>>>>> be the 2nd supported channel besides "main".
>>>>>>>
>>>>>>> I apologize on only noticing this until now.. I wished the incoming side
>>>>>>> can do the same already (which also takes 'MigrationChannel') if monitors
>>>>>>> init can be moved earlier, and if precreate worked out.  If not, we should
>>>>>>> still consider doing that on source, because cpr-uri isn't usable on dest
>>>>>>> anyway.. so they need to be treated separately even now.
>>>>>>>
>>>>>>> Then after we make the monitor code run earlier in the future we could
>>>>>>> introduce that to incoming side too, obsoleting -cpr-uri there.
>>>>>>
>>>>>> I have already been shot down on precreate and monitors init, so we are
>>>>>> left with specifying a "cpr" channel on the outgoing side, and -cpr-uri
>>>>>> on the incoming side.  That will confuse users, will require more implementation
>>>>>> and specification work than you perhaps realize to explain this to users,
>>>>>
>>>>> What is the specification work?  Can you elaborate?
>>>>>
>>>>>> and only gets us halfway to your desired end point of specifying everything
>>>>>> using channels.  I don't like that plan!
>>>>>>
>>>>>> If we ever get the ability to open the monitor early, then we can implement
>>>>>> a complete and clean solution using channels and declare the other options
>>>>>> obsolete.
>>>>>
>>>>> The sender side doesn't need to wait for destination side to be ready?
>>>>> Dest side isn't a reason to me on how we should make sender side work if
>>>>> they're totally separate anyway.  Dest requires -cpr-uri because we don't
>>>>> yet have a choice.
>>>>>
>>>>> Is the only concern about code changes?  I'm expecting this change is far
>>>>> less controversial comparing to many others in this series, even if I
>>>>> confess that may still contain some diff. They should hopefully be
>>>>> straightforward, unlike many of the changes elsewhere in the series.
>>>>>
>>>>> If you prefer not writting that patch, I am OK, and I can write one patch
>>>>> on top of your series after it lands if that is OK for you. I still want to
>>>>> have this there when release 10.0 if I didn't misunderstood anything, so
>>>>> I'll be able to remove cpr-uri directly in that patch too.
>>>>
>>>> I made the changes:
>>>>     * implementation
>>>>     * documentation in CPR.rst and QAPI
>>>>     * convert sample code in CPR.rst, commit messages, and cover letter to QMP,
>>>>       because a channel cannot be specified using HMP.
>>>
>>> Yeah we can leave HMP as of now; it can easily be added on top with
>>> existing helpers like migrate_uri_parse().
>>
>> This begs the question, should we allow channels to be specified in hmp migrate
>> commands and for -incoming, in a very simple way?  Like with a prefix naming
>> the channel.  And eliminate the -cpr-uri argument. Examples:
>>
>> (qemu) migrate -d main:tcp:0:44444,cpr:unix:cpr.sock
>>
>> qemu -incoming main:tcp:0:44444,cpr:unix:cpr.sock
>> qemu -incoming main:defer,cpr:unix:cpr.sock
> 
> As a general rule, if you ever find yourself asking "should we add more
> magic parsing logic" to the command line argv, the answer should always
> be 'no'.
> 
> Any command line args where we need to have more expressive formatting
> are getting converted to accept JSON syntax, backed by QAPI modelling.
> We were anticipating that '-incoming' should ideally end up deprecated
> except for the plain "defer" option, on the expectation that any non-
> trivial use of migration needs HMP/QMP regardless. If there's a vaild
> use case for something other than 'defer', then we need to QAPI-ify
> -incoming with JSON syntax IMHO.

Hi Daniel, thank you for the guidance.

CPR needs to open and read its channel before the monitor is available,
so the cpr uri must be passed on the command line in some form.  Is that
sufficient reason to violate your general rule?

If not, would you support the -cpr-uri command-line option?

If not, that leaves us with QAPI-ifying -incoming, which is messy, because
MigrationChannel has a nested type structure.  We would need to define
a flattened list of properties and duplicate much of the existing specification.
Unless, it could take a JSON object as its value, with all the {}:" syntax,
and be parsed with visit_type_MigrationChannel.  But I do not see any
precedent for that in other command-line arguments.

Of these, I still think "qemu -incoming main:tcp:0:44444,cpr:unix:cpr.sock"
is the least worst option.  We could further simplify it by allowing the
option multiple times, and only recognizing the additional "cpr" prefix.

   qemu -incoming tcp:0:44444 -incoming cpr:unix:cpr.sock
   qemu -incoming defer -incoming cpr:unix:cpr.sock

Your further comments, please.  I need a way forward that you and other
maintainers will support.

> Yes, there's still the question of HMP, but personally I'm fine with
> leaving feature gaps in HMP and expecting people to use QMP. HMP shares
> all the same flaws as our old approach to the CLI, of needing to invent
> arbitrary magic syntaxes which has proved to be an undesirble path to
> take in general. I see HMP as being there for the 80% common / simple
> cases, and if you need to go beyond that, then QMP is there for you.

Fine with me.

- Steve

