Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FE6C678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 14:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPMbI-0004vL-74; Wed, 11 Jun 2025 10:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uPMbD-0004v3-Tw
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 10:38:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uPMb8-0007tU-4O
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 10:38:42 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BEIxmG006797;
 Wed, 11 Jun 2025 14:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=LbpQlTqTyCBHtoKq2F6IBKv4eDzTmxk6owu7FfkisW4=; b=
 lGpChljKvn4yn1i54D/kLl91dD/cvXi6FD5PURsJ00D8Qu2fX7xFwUdTXHwIBx+W
 J38x4iCwD3S8Fbl4/cvgjn3j7huijubk55w5t3DrOUGu8xY7U0dMLBkoms6RDVuY
 cjhGBPJKAO9MnupqJgFVuedeME8wUD9D2yVvvTPvoJfTM/0juhgZFMbxV1dbbwvS
 OK2BP3Xc8mbUZFt2u01u3RDBRLLg601WxNRBWwZCYaNVWjMAPnQSTZ15Qps/Gy+q
 W/nHaeZY1pmbkIJ27PYKxEeP6OCPoVdzsG4pFtUkVDeY9zcVndf+fQpX9RvVk4mD
 7ycMsSnZfXg9v3ji8X2kng==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjxy33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 14:38:35 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55BEJ3NT011810; Wed, 11 Jun 2025 14:38:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 474bvb95xm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 14:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JucK/dm0SWq5mytM79o0VIBwNBtCMCOHbaON6O4MrEKDTMJEynWQL/gujaPPKfDlWj8O5t0WV/HnFN9Yw9XKCX6a+fH5aR0veq9DxmjxcrvwYRmgk84+SPB3hWuksDBm8enCQfe4GURWDaJkCFyn3FcPn1gQSgrS7I0+r3YjvjdGTfKtBjFUZSFxWK1M7y4iZcyro0kWRra2XZB3yW93t/WzqRcumILnrH49a9U192c+cCq8x++T/S4QZAQRAmwQ/gdVVMe7lhzA6w4fHEmQZzrqfa8BQ4Ci5hjS+4eElmiq2bdTc7OSkXR6lUPQmu5jovIZ60BPluWhxkZ2MLax7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbpQlTqTyCBHtoKq2F6IBKv4eDzTmxk6owu7FfkisW4=;
 b=pHz6MUHmp38Dfe2ZbWTbQoLQcqlEwqA/vse+Q9YWtm89eZ5qk97zS2iIHRklFsv3YAJ78XSO4IjVQW1EFDABaGjr7QnDSOGkcNAP+zaaCqnYFlHQ7VPpEfWnibbjb2+rJNbyJNoXIMJoYPoMkbdm5HxVl+NKR3Ge1NjIFs5Fq/1vSFinE0/pg+GSvBc8UaAn0SsADg0o+h/KUTweUlwpK6WjFOwEglnSkqLrPQOIxRzPjdFqofMjgAOYQteenoIgB+2AV3BE3TjGAk8qI1FoG+8xb8gv9qmw+VacMFyDAueJkh1XI7uNfpNC2CdkJEs2ttgTApDKCuZ2vZehP2i6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbpQlTqTyCBHtoKq2F6IBKv4eDzTmxk6owu7FfkisW4=;
 b=KvUoDipvXoR+OGXG5eptrWuY0LZzGo08LzJvhfsHhce99AKpHE/W+0ucl03EtghDofy7jn+yumbH/IHFMbCYS/UJPDWHE6IP2p/vkyT+f4nI+cBUIdY0FlM6hTj3FDwjvz6oKuS4+16Zlk7aAcMEJI8Q0e602eW7gRETEl9SA3o=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH7PR10MB7010.namprd10.prod.outlook.com (2603:10b6:510:274::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Wed, 11 Jun
 2025 14:38:31 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 14:38:31 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH 01/19] hw/arm/virt: Only require TCG || QTest to use
 virtualization extension
Thread-Topic: [RFC PATCH 01/19] hw/arm/virt: Only require TCG || QTest to use
 virtualization extension
Thread-Index: AQHb1wKXbwfaW55KnUG/YF2vFEM1RLP+ABMAgAAM7w6AAAHtgA==
Date: Wed, 11 Jun 2025 14:38:31 +0000
Message-ID: <82C9D448-7E88-40C0-9155-2578237AD160@oracle.com>
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-2-philmd@linaro.org>
 <EC334225-4D4D-4CBD-849D-86103C3D8BD8@oracle.com>
 <87zfeeic3z.fsf@draig.linaro.org>
In-Reply-To: <87zfeeic3z.fsf@draig.linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|PH7PR10MB7010:EE_
x-ms-office365-filtering-correlation-id: d6393a92-4fd5-4402-c746-08dda8f5a35c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OEkzMHJFdW5FS1lIYSszRDQ3ZFV4eHl0M25oUTdQamw4TEZ1RHI0cFFBZERP?=
 =?utf-8?B?c1hzclNXT1M3THh6b2hOYW5pQUxCVlZZeiswVjFibFBDZml4WFNCQkxEdFlZ?=
 =?utf-8?B?UE9jR1pHZkoxamhnRTJicHY2M3dmRjJ5dWJmaElnOU1MdER4NExPZ2N5YWJF?=
 =?utf-8?B?Skk4TlMwRDhqNFdFV0w3WkZRcDBzNFhiQ0k2eEVzd3ZwcEVQYmdCejlTUURM?=
 =?utf-8?B?Y2kvSjBXRkVCSjRBamhLWFdXdWdUT1FOUnZxTG5jTEw3VER0eWR3Y1pVMGV2?=
 =?utf-8?B?QklxdHhpVnFOaElrUk9tWUUvKzJ0clZTeU1WL1FQN2pycXlwKzkvNU8rS0xG?=
 =?utf-8?B?aHQ5aFRqSEhrNkoyV1FTVlEzVVVCSEtKSVZoUEpEeldOekdOUDNSa0xtdmZW?=
 =?utf-8?B?ZzVQN3B5MWc2TE0vMnpSL3BHcGM5TmtjOXNwT2x0NWJPMEFTak9rT1ZLSW9K?=
 =?utf-8?B?dTlmaHMwNlBFWWN6SGNjeE12UmJmYlh1TWorSWplbEVQV0NnZVZsOXNxYS9C?=
 =?utf-8?B?L1IrQk82VmVqZUNrenVrSndvNXh3aUtlUmNUZTQ1UXROQ2dRUHFMU3AzdENm?=
 =?utf-8?B?YmUzYjBxUGhhV0tzUnk1Y1p5MmhrS0kzK1ZSbjRidWQxMzVYayt1OVhhSDRU?=
 =?utf-8?B?djV5SUVLTkUySnp0VVRvVXN6VWU3dDN2VnUyUGxsYW4vMFFFeWJub05qTnNv?=
 =?utf-8?B?TkdKdVgyYVdGTXdpZnBzRTNiOHA5T2JtR1ZUMk5UVDVxNHlSNUdCdjFWMnZt?=
 =?utf-8?B?UE4rOGtKeUZUandsQld3dnNWMmEzMktvYjFyek1XT0VQd1NOUS9sc3Y5WS85?=
 =?utf-8?B?MDdYdTFTNWl0ZG1UbHhtY0N4TEJ1dDJJbmxJN0ExVzZyMGJqbVZpRkxhMGVs?=
 =?utf-8?B?ZzdtNTluMWkzUVUzVUQrNzVmZzdISENqdDJvY0ZFeEF1dlI0UW90dzBFdjd2?=
 =?utf-8?B?ZTB5WnVPMlJxY01ReEM1WklDMjVlcExWV3pZK1pLWXJNSVFXNXJrcHV4UzVE?=
 =?utf-8?B?Sk95Nk5vWWNpTGdSTjQ1NkNpUHp1RElHNzEzbEpINXRLSE5RTHFZenV3VWFk?=
 =?utf-8?B?emZ0a2JjNzBjRHcra2tKcFMzUzdPMVROYU4yUDZYWkUvaE5nR1UwcG1zUnpk?=
 =?utf-8?B?disxb2o0U0FSTEVPVENNa0xTS0FZWWpMdlpPZ0l1UUNpNFE5MGVEbVIyMWpC?=
 =?utf-8?B?RktZZnpPZzUvcW5XL3p1SUtTWDV5N3dxUElxTnd1by8xYjl2bjNqeEM0UGRT?=
 =?utf-8?B?YUQyeVRKRzE2YTBsV29uWThCVzJUZGFEcVl6Zmh5STVteUxtVktWUkxvWWNz?=
 =?utf-8?B?SGxIT1pBcWdBSlg2UDNaRzFpTng4NUl5Q3N2YTNhZHIxeUVGOUxTZVhnSnl6?=
 =?utf-8?B?ZVdYaFQwU2JYLzhRazFoZUFUWmFCVEhyT05ZMU5aT2RNVGkzSHM1YlJCZzJO?=
 =?utf-8?B?Zkxxd2NRdWlWMk1MU3g2cDc4QUh0UEd2b0ZlbFJvRWFoc1hUdXYzUVdJS3RT?=
 =?utf-8?B?NU51My84OHJhUC91eTcyZGFyQVF1RXNaK2J1ZWFuRk1tNnF0dHZXcVRxbnlt?=
 =?utf-8?B?c0djRkVESTJzVkZLU0xOcXFVNlZ1WWt6aXB4Q0k2TnlFaytXcVZXM1VFUzJ0?=
 =?utf-8?B?M3Iya2NYYlQ1VVlJR3drVytmZFVmZXBSSm9qVjBBZC9venpsbEs1YWRucEVx?=
 =?utf-8?B?bnlXbXJFMGludGZLVENBK25EYmRQMTJ2dkVFeFdyVWZjdjN2N2t4L3YyOXpl?=
 =?utf-8?B?Y1hnbWROUWdpZ2t5Y0pveFNSd0JCYWt2aTU1NjM3OXRnelJ5MHZzMnk4T04v?=
 =?utf-8?B?YUU3WmlwYS9DaWZYbllHUUVuRjVOL2d4Z0k5MksrRUlyd2ZwVlkwQitjd2g4?=
 =?utf-8?B?SHZwVzYzRWdodGx5cjRkT2lmU2pianJLVEwvblN6a2d5MVliNk9RM0RENzNW?=
 =?utf-8?B?K0lWbUZZTWVmWDZyMExIUEFhc2tNNTFaSzRuOUV0elVBUTRodE51QTYycjZ6?=
 =?utf-8?Q?Rweu/9FLUX8uUJqTj4i+ZoyY/KCueM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlFmenY1K05SS1BsbFRFRDFOSlF6bFVMQzgzQzZLU0p4clFTaEtqU1VUamFw?=
 =?utf-8?B?cGVjaHpDNWh0dDg2UThpM2tlUXpvZXNudjhhV2VQc2RFbDdTZXdZT1FsWU9I?=
 =?utf-8?B?RG82OUNlTDlHTWt4MUQ5T3lrM2xUWG1zWEpLQk9ZTXR2d09qdGZjR0JFdjd3?=
 =?utf-8?B?TWhpa0haNWkrdUYyMFcrVkNDUWtkRTcwcXNmWjJDa0FNbU1VajF4QWZYVlZm?=
 =?utf-8?B?SmVBNnZraFNuZnRldXdybGxLY3FRbEVDWEhpeWV3RVR5cENUWWRWaEhYQTlE?=
 =?utf-8?B?K29XMXB4VjNsU0VrR1JzaXZiR1VRVFlTQmh2WjBDWW1WTk9seGpCTFhQMHUz?=
 =?utf-8?B?ZG1KWGIySndTYTBNZThqZnFFaFNXSzJNYjdlY3MydjNQemN6OS8xMlpwRVMx?=
 =?utf-8?B?cjRUTUp5bEo3eTFMbElVdjdnQVlYRlVxTE5hSnhEd09aUVRaNFh4NHh5Smsr?=
 =?utf-8?B?SEdGajJrK1IrVWx2R1FreWZnSWZpSi9iUWNCd0taTGhYTDNCMUNSLzFEeFFX?=
 =?utf-8?B?TWVKV29JRjBrOEc1K1A4dVI3QXpmcGhJUjhZWm5zeGRYZnR6b2RrOTFlR3VC?=
 =?utf-8?B?ckJlbDBPbjlyTFUwYkQzVGNWbVN2cWs0ZzNGWUpPUmdSRm9zazJrVXpjUk8z?=
 =?utf-8?B?dHRaTlkxTTRXelhOalZjSTlNVlpyWDZzdVJVc2Q0RE9MeWhjUjlSOWxiNWhG?=
 =?utf-8?B?QnlWSERPVzFVdUhCSEdmS3R3TndLZG1qZkpLK1BYUk90WTE0Yk80NENzcDE1?=
 =?utf-8?B?eUI3V1EvMlVyNHBkeWRyYjVMbjBtckIrV1JoVXB6TjlocUJoR0RzRllweDRZ?=
 =?utf-8?B?Y09ZZGM2TVNPY1M5WWVqS09lanNhN3RLSFJKS2N4ZnQ0YTBHR2NIRko4YkJq?=
 =?utf-8?B?VE5qclArUkVPRjBEc01BbEFQSkVBQVZzZGFrWWt5NGxKNS9uNWc0ODcyTlA4?=
 =?utf-8?B?ZnhHcVV4TmhHY1Q3ZUZYbGF6ay81T1l5bHJNMFQvVXU2NWNXcXJkSTczNEVj?=
 =?utf-8?B?eWM2Rlpia2pZVWlzc0Y5MllZejFrbTByd2ljaHRRZS92ZmpyZUZFZHpCMVJS?=
 =?utf-8?B?bnlucWVKVzFSblRUU1laT3lXeGJBQTNpOXdCeVdUY25LWjQ2UCt4aWptRkdz?=
 =?utf-8?B?SUs3YlI3Mmk4b0hZTWZISElaVk00bUl2RzhpVDVWdVljRE15ay9KRGJMTzlJ?=
 =?utf-8?B?SzhzbVc1dTgzNFA1K3pqY2I4YUFOSGE5UkJXWjduRlNZV1hyQ0pDUzBxUUxk?=
 =?utf-8?B?WUtNbHZWZGtTZi9Mc1laMmEvVzdKSkVWbDJEQys4UWZIby9VbEFOdW44Q21F?=
 =?utf-8?B?Rmx1ZitpbVVHaEFCTGRocE9GUFdRSGFtRnp3VlZuYnlKVFhOdDdjeVhkN0t1?=
 =?utf-8?B?UUx3bkxYaXgvL1RQNlp4QXpGUnRDOVpHWWdyVWw4VTVHWEl6MEw5SWpWakNB?=
 =?utf-8?B?dDZkUElWODYrM0JhU2hpNUJJaDhLeUluTU1qdkZXc1VoOXdZN1V1aE9ubStm?=
 =?utf-8?B?QXZ0VFpybUo4WGtIMFg0d0ZBdEkyWnJReVBGSWZOR0lkUU1aTGhvNnpPcHZS?=
 =?utf-8?B?OVplQzZ1MGlLdTlGSXRVdWNjQS91ZHJzQ2pSQzJuazVLRWhqd1JodUdqZG5a?=
 =?utf-8?B?b2NMOHRlYWRSdzU4eTJMY21vWUhkN1E5ZldGWHVmdnpPYTRVNkI3TmtubkFq?=
 =?utf-8?B?ck5oZnFiRFhYNnBVMWVmNXQrdHVUTG0vWlJrdkF4amoyaDlSUEozRUk3TW13?=
 =?utf-8?B?SGcrdzJpR3lTMnB2Q204ZEx4bFl5TlFrdEtFQ3pCMGhZZmVWMXFNR0Vld1dN?=
 =?utf-8?B?eW1RTWZkN2RZM2w4M1hlYVp5em5NcS9Sa1N6b0NsR2NvdXRVOW9SdEFIamdz?=
 =?utf-8?B?RWNxNE9Xbld4NmtTaVl5L0lDSUpEZUNmQzJwVDZLdUN1Y1RmdWdGK2tpM1hW?=
 =?utf-8?B?VUNPNTNVTEZ3R2h4Y1JGdWRSaWc5VjJrTkx2bnJBUEhydlRMSk9KMzFScmIv?=
 =?utf-8?B?endEUXo4ODlmcFRjbkxzVm1IaFhJYVp4bFIyM2Y5aDNIMDI2SlFIc0NiWHVO?=
 =?utf-8?B?cDQ1aUg2UzF3MFFGdkZoVXhBNDRZNWpRT2FwN3I1S29aZWh0eEcrMldIL3Q1?=
 =?utf-8?B?a09TaUkyY1orZTRjbEY3TzRoZEdZbGRWU1drVmpEOXFkd3BEWnNHV2ZGTjYy?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED4D465853E01347A10150A317C84FCD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M4kJsC+LnJ9CCLXdzPv2vtN56PdRpW+AuwRi7f7DKEWKcOuA+uCWj2Ej75vSDkkQytiRqnY8M0Xu5GiUPmOWM+P7lri6ftNR4j2Q7RZGS/OshjDqmvPgibtmpoOvSyU38XI3Zlatcfb1Up5Yx6jlciVJFbUg38xg55xUaVTx7IAdQgwTs+BeXpt9M6Kcuu6odjvQJQ92YqQp2zlS8as3zrL2sya5yBSsfEst/GHEo2QIhLYxwaRk6BOTOEWGktaiwASUIKEOvJiuPFbuq2k/5SSQOhZbUUn88rkhWyoBHJbktMc/G7XvzAd1WAsqp+yo2WtDyNeyCd4qtdAyOlkyRABqe9FEyApNxQmA3hdp8NwgifGHtAbDg4D/nCAFzE64qQaM8txQbBVc/WrckUZwmYTTYLCAMXRDgfTFQGWqUuP8wrADm4TVJM3YoMQJHuAPWSHP7+y6BWTctAAtA2YASStoofV84gfgxg5J4oP4xPDw0+iQex9rcASsn5ob/YbxruUpD+a9q9jTjXyKaZswmLeiFYZh12oKG1s8JhI7MK23fm/kypPupWZJK8NNrWVTLnSQddACXoYySxIIY9v682RuR8mVyhyOENrhoKNAgiI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6393a92-4fd5-4402-c746-08dda8f5a35c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 14:38:31.7176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yiXGlrs9zIKJKxAxNj4P35Y0E9uaNo8sEDAOHOcYGrHT97jPSUT12lP3aYriR+mLXLB2QFQqY7xxVkoa5gp0Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110122
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=684994eb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10
 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=Ss5s3S05k5883ltk6PAA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEyMyBTYWx0ZWRfX7njZh+LinhW6
 t86sxGbJKu86OQBIS4qHblFvK+31z5YCTys09IrpwLGSFT4/SQslBL0mQCue4t22kY5hp8q5exW
 QjHKpenvnKGjAF5JqYS18BkCAJE1JZV7i/r/QklTkf4o87eWPMjLA3tpHk0+ShM0anJceuvACTt
 D1k27sXTQ2OBeyblgDyuyIv2+3lONV4QxObqyeBuUXRz7lhPSXXXyV1vlClsA0piUrXvznKAN+4
 RrMi7i/kOTXmmGp4Zslagg3joWUHTkyQDANU4zzbv3Z49wyCpKE3HcZGTXH9czVAZP5MBte9ceW
 9W/1+K11Ew3/rTps4wlghYPT+tYZauNG99S6H4Vg75VDTgbMbVYTHeiSJ91JlLQMV1kSgq6W04Q
 ZNvBSaAmjh3ZOn7B442uF64Cyypd9mL4trTicY3C6XxZJrJjtZ5od62MpKlgcykNURzxw6DY
X-Proofpoint-ORIG-GUID: mz1YjfMDF8chcLXrPxAEx8Bxbrt81iDE
X-Proofpoint-GUID: mz1YjfMDF8chcLXrPxAEx8Bxbrt81iDE
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
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

SGkgQWxleCwNCg0KPiBPbiAxMSBKdW4gMjAyNSwgYXQgMTQ6MzEsIEFsZXggQmVubsOpZSA8YWxl
eC5iZW5uZWVAbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1
aXNAb3JhY2xlLmNvbT4gd3JpdGVzOg0KPiANCj4+IEhpIFBoaWxpcHBlLA0KPj4gDQo+Pj4gT24g
NiBKdW4gMjAyNSwgYXQgMTY6NDQsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGlu
YXJvLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPj4+IC0tLQ0KPj4+IGh3L2FybS92aXJ0LmMg
fCAyICstDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL2h3L2FybS92aXJ0LmMgYi9ody9hcm0vdmlydC5jDQo+
Pj4gaW5kZXggOWE2Y2QwODVhMzcuLmQ1NWNlMmMwZjRlIDEwMDY0NA0KPj4+IC0tLSBhL2h3L2Fy
bS92aXJ0LmMNCj4+PiArKysgYi9ody9hcm0vdmlydC5jDQo+Pj4gQEAgLTIyMDUsNyArMjIwNSw3
IEBAIHN0YXRpYyB2b2lkIG1hY2h2aXJ0X2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQ0KPj4+
ICAgICAgICBleGl0KDEpOw0KPj4+ICAgIH0NCj4+PiANCj4+PiAtICAgIGlmICh2bXMtPnZpcnQg
JiYgKGt2bV9lbmFibGVkKCkgfHwgaHZmX2VuYWJsZWQoKSkpIHsNCj4+PiArICAgIGlmICh2bXMt
PnZpcnQgJiYgIXRjZ19lbmFibGVkKCkgJiYgIXF0ZXN0X2VuYWJsZWQoKSkgew0KPj4gDQo+PiBE
b2VzIHRoaXMgbWVhbnMgVENHIHdvbuKAmXQgcnVuIGFhcmNoNjQgTlY/DQo+IA0KPiBObyAtIGl0
IGp1c3QgbWVhbnMgd2UgY2FuJ3Qgc3RhcnQgaW4gRUwyIHdpdGggYW55dGhpbmcgYnV0IFRDRyAo
b3INCj4gcXRlc3QpLg0KDQpPaCwgb2YgY291cnNlLi4gbm93IHRoYXQgSSByZWFkIGl0IGFnYWlu
Lg0KDQpBcG9sb2dpZXMgZm9yIHRoZSBub2lzZSBhbmQgdGhhbmtzIGZvciBjbGFyaWZ5aW5nLg0K
DQpSZWdhcmRzLA0KTWlndWVsDQoNCj4gQ3VycmVudGx5IHdlIGRvbid0IGhhdmUgTlYgc3VwcG9y
dCBmb3IgS1ZNIGluIFFFTVUuDQo+IA0KPiANCj4gQlRXIFBoaWxpcHBlIGlzbid0IHRoZSBzYW1l
IHRlc3QgbmVlZGVkIGFib3ZlIGZvciBzZWN1cmUgKHdoaWNoIGNhbid0IGJlDQo+IHN1cHBvcnRl
ZCBldmVuIHdpdGggS1ZNIE5WIHN1cHBvcnQpLg0KPiANCj4+IA0KPj4gTWlndWVsDQo+PiANCj4+
PiAgICAgICAgZXJyb3JfcmVwb3J0KCJtYWNoLXZpcnQ6ICVzIGRvZXMgbm90IHN1cHBvcnQgcHJv
dmlkaW5nICINCj4+PiAgICAgICAgICAgICAgICAgICAgICJWaXJ0dWFsaXphdGlvbiBleHRlbnNp
b25zIHRvIHRoZSBndWVzdCBDUFUiLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgY3VycmVudF9h
Y2NlbF9uYW1lKCkpOw0KPj4+IC0tIA0KPj4+IDIuNDkuMA0KPj4+IA0KPj4+IA0KPiANCj4gLS0g
DQo+IEFsZXggQmVubsOpZQ0KPiBWaXJ0dWFsaXNhdGlvbiBUZWNoIExlYWQgQCBMaW5hcm8NCg0K
DQo=

