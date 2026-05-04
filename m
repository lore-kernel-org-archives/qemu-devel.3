Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EAFFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 14:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJu7S-00011w-85; Mon, 04 May 2026 10:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wJu7K-00011i-7J
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:17:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wJu7H-0005hw-Mg
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:17:49 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6448fTRS250336; Mon, 4 May 2026 14:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=8x1P8EhgBL0BsXoxmK
 sSPnPB/ZlyBPNHln8wLkszfA8=; b=bOIxY/rRnmOE9IrtLSh5f+9Myg91DiYvZY
 9z3iTgKqjrpFsEgqU4I0yLqjVuJ6A3iY7kLZr4RUrnXwd5vWnWsHrHT5dvynrj0k
 qsOLwSQ5ciKtraXyvZZAME+UsMoevj7941omOQ0HDsNsqO+EfaVWrn3PKdbHVqjg
 +LwmkwkyaTIKrM7T7WtKzumLcZNjISMKfHqtGOYoxiJQ0X4U8vzP3iBgP7Cne4Rg
 BHdS6MkrcWhJpUXNVCgTdm0n61vTEANjrEc8U/BEZXObJEaib06cBhThqpPIMl2d
 AG+rARhfVZYykhoqVPrNT3XkMRVRGAhJvkGOIVkEUS/84lGaTudA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9e1arkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 14:17:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 644EGSHl028914; Mon, 4 May 2026 14:17:40 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4dx590uggr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 14:17:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfzswEKx++7sw8fkYm7PDf4luGA7MEt2qRA11rXJ58at0C52L/6gpk9aySBykyAmL26+WEaQbq2bA38UuVfV8L3z/KPLFJBXWM3oq06bkdJ+T2O+WQJcJpxJqE7E4bU4UcWLalqxLxM1ovTimGEJJndWA5o06/Np6M3I9LJwkAH9HCGwwoVM1lmU6t8PMMNTuHm+oyCWUZNh626vnQDmBchbXi5kCRWJ6PQk6W4jECd1F0i8phT/hDALCVexAdMS26xOj/66t1kesJA3u4S+k6wgvkTMpWVU5xcwSRm6HZ/VWbzsCC3INym/E+YfxbtKrowSMdI3uZMf5/Vbg5tRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x1P8EhgBL0BsXoxmKsSPnPB/ZlyBPNHln8wLkszfA8=;
 b=LHcZeZL8yU9LMxOXr+LjsDcOde5Pcq2q6JJavB5K8XVdLdq9NMMYEklMI0/g1OXN5dC67BXK+IpiMx90RHHNGsg1bwNklz/nW4mu4jRufQRfcHS9FOrZOnWub9HIOAgJBWIuXD5OZ9zD0Xe4V+hPOalPSsUlNl8vdj5cOPzLm0fXZ4OfXvFVe9trEaM0bZkaGpDljd1KfoI1R1id+zblh+Z9AlYSfJ+vG1K8N+MY4Lpijb6J9EucKaXD6L4/rJeNWPwobOI6q05MJ5nwAjMGi/FZeXhtDjWzXaoVK2XUsdjaZgAk2MLaiPPvUAtXq/46AgwZP1yg00G3UAKK1Ym4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x1P8EhgBL0BsXoxmKsSPnPB/ZlyBPNHln8wLkszfA8=;
 b=OafOSmkvXBlNIXAe4qjLhdpUmMYpgxWOhysWLvtHH7LvohcLzhvfNu6odOjCNJhy/7U4mW0r0zdTQ/xZB1I2Lsgm+O9UgvRPKqTaz1Ux+iPOglchb6SGNcYPkZ9DLORFGi6GZuy2L2/GT2ioXJ2IpM3Dg7oneZLD6jgyXHValao=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by SJ1PR10MB5930.namprd10.prod.outlook.com (2603:10b6:a03:48b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 14:17:35 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 14:17:35 +0000
From: Jag Raman <jag.raman@oracle.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "armbru@redhat.com" <armbru@redhat.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 11/46] hw/remote: guard listener unregister in finalize
Thread-Topic: [PATCH v2 11/46] hw/remote: guard listener unregister in finalize
Thread-Index: AQHc27o/yorygZHK5Ui2slbvi/YZhbX96eyi
Date: Mon, 4 May 2026 14:17:35 +0000
Message-ID: <IA4PR10MB8301B9F70C8CC5326A55D41090312@IA4PR10MB8301.namprd10.prod.outlook.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
 <20260504-qom-tests-v2-11-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-11-ef7e3dc94f7a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-05-04T14:17:07.4596160Z;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients; MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR10MB8301:EE_|SJ1PR10MB5930:EE_
x-ms-office365-filtering-correlation-id: 20f2670d-5c95-41e1-11c9-08dea9e7e39c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|8096899003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: DuWTwVQKO9eLL/KJADWcBIvECJ7GLb8bU9LrXRU9XLkc7Z/OR2vrkl0ESZ4yvtCqh/snyIp/WtgQBM4GL5hLsq+5bGnjzKeMd70fIzXsZaOZOIo0hx31IqGerSFCnXaxB+6YBH3t0wyL+kjzpp5XMBVxVZm9V7eSYGQNoCZF/o1EQPNefkFYhh4bgLPKU/8gLEEkUkzgLH//rOPS26zKePU5uSaWgscKl/Y/lyCfmSedRKPA0ZCxoD14AOjtxfHhQYSmG/8iYnuqhHZWFHjOUKYRW5/T1S6W8rqhMZovNO1xiPKBn6rrud76ab5r35S05xw7m4Rcbi9IBlgnDp51zZ4XFrWabLB0pj6DW1dK6tVYCpImceEGyDlR57hws3PvwFbWklAgT9uBgO2hzD5RGg5MJiVpnPC9U09d3AwaC4DmScBt6aZXOuJIrHNkI9vdVrvvYG9tXZe7mzZMno9jLg0uePz3Isu8wQOKz4RIqLL+tNtyp54EsNpjHD/rJ4hJSD2A/vDgQlYgxVfeoZTWJwbe5+bJGNZ419YaQplSXcrfPUHIw3Cf3v+kmkwcjy+6vAYd/AQ06iiyXqKuzD6ZdE79fOIPGB3s3xGDrz4HiE0QO45mHh1mZbF9PLL1iLTftdTuBV3gmjwTEQ6kNZb/TrEJrjhiAdwnL0sqrIE0O34bRmpvE66Wyg3zBWJImSfHUruXCTzdqazMP7Od18+pcuX22+iAoRBBRemlxpD0tSapUe3eBco1r4Z06wcXniDT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(8096899003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2dqb0lHS0hmMEZtUGRLSWJRZE05SVAxSllsKzhLNVNOUHl2VCt3LzJkM0sv?=
 =?utf-8?B?c2J3bHp0UnZoZXF0K3lZMVgrQmVUV0Z5TVlyaXMxRC9QOXlrR0pVcGJPOHls?=
 =?utf-8?B?bStRdENjcjZwMFkzbWpOWm55eXlyb1U0Y3NsYmZnYlVKSnNnbVVLUlJyZGw0?=
 =?utf-8?B?TTFBMXdDczArQU9lL0xJbGVHYnlaaENBcDdYelJ3VkFuMEI2ek5IRzMrbS82?=
 =?utf-8?B?aGRYYUpDcEJ4YzFvb2Y1NmJhK2pMazNrejhFOUNRV01SN3RBT3RoT2xkQ0k5?=
 =?utf-8?B?WFhLOFVvQ2x2Q2puNUZGZGtnUXBtczdHMFBnSVBVY0ExSWRUNDM2ckYxMjBC?=
 =?utf-8?B?Uktwb0E5K2RpNzZUdWNPdTJRbUZzMThqVVE5eDhFUWFlT0FDSk80SFl5RHJF?=
 =?utf-8?B?cE9WdHlXNWZtOHNMSHFBM2cwTml4YWJKK2orNndvQVplYUlweUdlODZNQ3hP?=
 =?utf-8?B?cnozaldqNFNMSDdmWnYxVStRcG40L0tZQ0FBNTBJb2NEMVg2RW9aQWxuVVd2?=
 =?utf-8?B?OHFsZEp4WkNCL0d5THFzek5KWklTNkRmN0tMdzhzQWsvRkE3c2JXN3RBVnNr?=
 =?utf-8?B?eHFMTkhhSG9hd0JlbTFSR0R5dW42bEQzalJRWWNTNmN4OURzMzY2dW5TUEph?=
 =?utf-8?B?V25sMm5OZjV5M2dyUExNQXM4R0JHWHllOTUwYWw2UG9xdFlZNko2Y2lSVVlk?=
 =?utf-8?B?cVFuam81b2U4ck5zeGVIZVVLVzZLVUpzU255VzN2ZlI5aWdBRFI4Nzd3ckxN?=
 =?utf-8?B?WENIOWdDUFZ3ZXorNmRQZVBuWGNIVjVhM3daUVZiM2xDTUxlbHpWOUtEZ0x5?=
 =?utf-8?B?RlRhK3JXZnFkUUk3OVlNN0tzQjlLQTd1YmZPT1BWRjZ0WjBiZEl6WmU5Q0ZE?=
 =?utf-8?B?dTJBcVJEM1ZaVXBRQW1VWkVkeUwrL09CbEE1U2hsZ2pHT29YRVk3TEZEWUl3?=
 =?utf-8?B?K1J2UVFyTEFhS3BtNlpPSi9kY3E2Mm9HTHJJOXEzL1R0azhHL09ha2hJcHQw?=
 =?utf-8?B?UGtoNFN4Yk1zdjc0YnBwc004eE5sQlNENHU2cXBGaDRMVlpGc0NZMk5oM2hL?=
 =?utf-8?B?aWV0Z2w3a0hGdGZHZVhPelBDZkhSQjVueXViNGxmMHBwdkFJZDlpOEJUK1NK?=
 =?utf-8?B?d2JnUER2YUV2Wm9oOENqakRYQzFIRUFPK3RNQ3NMcUxQM2Z0TnNEU2xjL0JI?=
 =?utf-8?B?WGNGUnYzYlA2RDJDQVJZeE5jNWRrblROSVBoT2FWcHgrSkZYY1Q5WjlRQ1pz?=
 =?utf-8?B?NUt4ZTVnS1RrQUVlU1Y2c1FYUzN2aXAxK1NSbnlOWDNEMzVwRVN2NHZHRzZ0?=
 =?utf-8?B?MkxrRGE1akVJMHBWUnBIcFJLZkQrVkt1THdWM0hLZ01QblBTclEzMnJtanht?=
 =?utf-8?B?OWlzdWNhcit0NGx5U2pseUFQVkx0WS9GRDF0QmhQYlZzbXZTMzhPczM2TUZh?=
 =?utf-8?B?MkFvMktwK3RxYkRyZ2dPWVRaeWFJZDNxUHhlMTZYZEdjR1hoQ09BbzNQSTJE?=
 =?utf-8?B?d3NFTzRBaTlrWWlDZjMrcnI4d0hGL2oxRWpjZmFudXJDTTJGM2tqWGE2bW9R?=
 =?utf-8?B?dzdNMHhOcjJEUUxKV2xVRzdMclRvZ3E1YU5sZ1NzQm1ySnpuQzZ2UEF4Rm44?=
 =?utf-8?B?L2hZTytNVkZMUElzUnNFZzhneXZJVXRPNG1CMkxYTXQ4WUdieWdTOEZYbzVy?=
 =?utf-8?B?VzR1WkE1djlJbWlMd1IxQ1lsaG41OG9HQVlacjNpQU9NblRldkUrOWRRQjdi?=
 =?utf-8?B?b0ZkWVJvcmVLRXR5WTljNzRkak55bXlndnkzcHBMK2Z5cUFDU0t5bWhTN3ht?=
 =?utf-8?B?clJaUG5tSGVFQk9YWW10cUUyV3BqT2F3UDBIc1N2THpGR2F0WjhtRmw0amQ5?=
 =?utf-8?B?MzZXVktUaFpiWFVZVDFTM0xkdUZhOURJbHJLQ0t1Uko1Z1A5UUxWRTRhWnlL?=
 =?utf-8?B?NE1mOGdIUkxpQ0FGUTlRbm1DN1QyVFBHaVI2V1lzR3VlNDgvV3hHYmxIMWxp?=
 =?utf-8?B?Zi90aE1FaHdUU29WNm14S0p4emNlNjNXTHJiWWh5UDdhSVNDbWxVM0EwYjVw?=
 =?utf-8?B?MElFRWFiQnJneWxaR0ptRzhyY2svNmFhZzRpU1dvSU9XNzlmZSs0NXpjc2Z5?=
 =?utf-8?B?dWJ3aUgyNDJhdUN3eS9uT0ExdC9jZ1FUMXI0ckhNWkNyaklvSUZSZDF5T2lI?=
 =?utf-8?B?b3oyY2pTTm1UK1JvM1hGYXQ1VEVaWnI0bit4OGhLdFMza0Rrb3FTRFBEc3p2?=
 =?utf-8?B?cWROanpuOENGOE9UVE5UaDlsMGNWRzRZT1VGdUU1MCtQWEJDNW0rY3FLOXA3?=
 =?utf-8?B?OHhEcGpKS2VlWGJtQ0s2bDB6KzFYUTlKM0MxTmhLaHVzRThIRDBXbGduK1lq?=
 =?utf-8?Q?Co1szmMQFxW106HE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA4PR10MB8301B9F70C8CC5326A55D41090312IA4PR10MB8301namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dz5EgQ/WjfkeZoL7Pli4R9tSVld5FRFDeDa8o9FCf/eLj1ailewXuIHSdJuWlA7EOkiqc+acRBCqMbMKItwBrT3NuJuAOgQtwYbw5/bfoNe9Z1yLl1KbDFMyvFzIxhZCqIVlWTDC/3J1Mve9UM0lYQoJBYV3Q5i9riQv3BtbmgE+Ow7oDnre7ejyyas3tFdwlyx7EX6nyXlua7bbx2+0X7V0Lv0YbEQTvAuzY3B2mXywg1UnllX++Hp+nSMM1A6avyD94mREUYP6TbA97E9Rz0u4l2JiyT/pSl8fpv5Z+ZKk2qXByoQkodOe4MF91yLjb668Z7s/8wdOJrtZKD2g1w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y/XUGYtzvMVbIs/Ci2okvAK5qXUblJX9vMSyFOTQRLhUki2m2NKeO8DTrZ95Yz8F7sqk2Jluumn0Ipr2or8UoraNy6FD2hFB5/0Zk4owMAr9fHlSUbMFPb8/nLHmX5Gvmo3PTXXsIxjdVb35tovfwtb0wuTnePs5cuOy2FtcVft/VPu9pYrIsj8nUOC14edjFouoKuhyqCA+q9fTugwoXiYlgiOqqJ3c6062dgCx3XD64PfIBuG2wfygi7CR2kv4qNXQsXpgELhpJh2wyxBoM+7uRsLgVQwNNkLS/TRt2J++X/bjsYku2X88plxh+vWX/NcsvgWafkKX6VrFCosu9FZCAROrgw3CTvfLxDXn7MlKybRUeqMJ9cngTBI9lKAlJxGACf0MIdIkXceFOgsGAc9QZZlUsHlb9UGmg3hj+h6HOvj7sR8qKSRT7Zb42JBBckX02smgukqYtUE3Q+9eQG5OjKPkVpuMlYivvXdOPWfaM4EBu59qBwr7OZyCHFILTj6WISp86IQPWEVfXn5MaG87Nmhxi81J/MMbc4ZFzShgRgGHMJKpspLRlAJ0lhjac2+75tr+Ern2z7BRN2H359Z5xfH2e3h8dp2CiaV7Wk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f2670d-5c95-41e1-11c9-08dea9e7e39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 14:17:35.3886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +B7sJq3u1a4T04cs1QL7sOUfdmhAbIA94ExM8qdwZf97iX+ZBm2i784izl8f8cF4gKG3OSFqFg1fPRJo0xOAig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605040148
X-Proofpoint-ORIG-GUID: zrMfVGsPFTVf5ltieW2BHey23LO1nURB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0OCBTYWx0ZWRfX/ldJbQUbYi+L
 RUl/rWvK3C+jlzX219eNDi8fGcPIE+Ekn0ekU4Y6u+F80MYmAHkIFP0YyCmw9CypPGxUSxegXov
 CMQANaelOuvWQuVlwRT+KHrZ+22lY9w8wUKVtdT7xP03CQhv7qNyQ/uXX2ZUIOoYkz40Bu6rMAM
 t99IYMLICZBwWrcxOZKfT7HK83iKRDTwYQlbcNJPWvM9N0UZWD5R8XNLrtjgebe37FuTizNDwgk
 R0+qErdowJWr4HnK/DptKgJSQB5Sd3vaI1dWVmnt0qrwDuWlKfdPZQ6htJAjj/ZrqBRkFAP2MzH
 BgxDm63cEoobV/x/L6yIDmRTKihNV+QXADdMFaFvasWwv2drGDFEPZTVBrZnf8vYMQfd7gvNUva
 xy+Lv65kHwMQnJnDUGtuB8vpl1a3zblQ0egzUDDLHUb4wo/S9BKsRKdzFyLKXl3vN7Ffhx6T92S
 9cEh06YeCa57Z+ePILw==
X-Proofpoint-GUID: zrMfVGsPFTVf5ltieW2BHey23LO1nURB
X-Authority-Analysis: v=2.4 cv=OPAXGyaB c=1 sm=1 tr=0 ts=69f8aa85 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22
 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8 a=rpVI0ituOFzdEv5A3zkA:9
 a=QEXdDO2ut3YA:10 a=gfSeSRDcTySzKtuFkrwA:9 a=qXvR3sbf0aIo6GD8:21
 a=_W_S_7VecoQA:10 a=Fg1AiH1G6rFz08G2ETeA:22
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_IA4PR10MB8301B9F70C8CC5326A55D41090312IA4PR10MB8301namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Q29uZmlkZW50aWFsIC0gT3JhY2xlIFJlc3RyaWN0ZWQgXEluY2x1ZGluZyBFeHRlcm5hbCBSZWNp
cGllbnRzDQoNCg0KDQoNCg0KQ29uZmlkZW50aWFsIC0gT3JhY2xlIFJlc3RyaWN0ZWQgXEluY2x1
ZGluZyBFeHRlcm5hbCBSZWNpcGllbnRzDQoNCkZyb206IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFy
Y2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KRGF0ZTogTW9uZGF5LCBNYXkgNCwgMjAyNiBhdCA3
OjM24oCvQU0NClRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcgPHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zz4NCkNjOiBhcm1icnVAcmVkaGF0LmNvbSA8YXJtYnJ1QHJlZGhhdC5jb20+OyBNYXJjLUFuZHLD
qSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT47IEphZyBSYW1hbiA8amFnLnJh
bWFuQG9yYWNsZS5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggdjIgMTEvNDZdIGh3L3JlbW90ZTogZ3Vh
cmQgbGlzdGVuZXIgdW5yZWdpc3RlciBpbiBmaW5hbGl6ZQ0KDQpHdWFyZCB0aGUgdW5yZWdpc3Rl
ciBieSBjaGVja2luZyB3aGV0aGVyIHRoZSBsaXN0ZW5lciBjYWxsYmFjayB3YXMNCnNldCwgd2hp
Y2ggb25seSBoYXBwZW5zIHJpZ2h0IGJlZm9yZSByZWdpc3RyYXRpb24uDQoNClRoaXMgaXMgcHJv
YmFibHkgYmV0dGVyIGFkZHJlc3NlZCBieSAiW1BBVENIXSBxZGV2OiB0ZXN0IGlmIERldmljZUxp
c3RlbmVyDQppcyBpbiB1c2UiLiBKdXN0IGFkZGluZyB0aGlzIHBhdGNoIGZvciBjb21wbGV0ZW5l
c3MuDQoNCkNjOiBqYWcucmFtYW5Ab3JhY2xlLmNvbQ0KRml4ZXM6IGM3ZDgwYzdjMWQ5ICgibXVs
dGktcHJvY2VzczogQXNzb2NpYXRlIGZkIG9mIGEgUENJRGV2aWNlIHdpdGggaXRzIG9iamVjdCIp
DQpTaWduZWQtb2ZmLWJ5OiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVk
aGF0LmNvbT4NCg0KTG9va3MgZ29vZCB0byBtZS4NCg0KUmV2aWV3ZWQtYnk6IEphZ2FubmF0aGFu
IFJhbWFuIDxqYWcucmFtYW5Ab3JhY2xlLmNvbT4NCg0KLS0tDQogaHcvcmVtb3RlL3JlbW90ZS1v
YmouYyB8IDQgKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L3JlbW90ZS9yZW1vdGUtb2JqLmMgYi9ody9yZW1vdGUv
cmVtb3RlLW9iai5jDQppbmRleCA4NjE5MmRjOGRhZC4uNGU3NGFlNzYxNTggMTAwNjQ0DQotLS0g
YS9ody9yZW1vdGUvcmVtb3RlLW9iai5jDQorKysgYi9ody9yZW1vdGUvcmVtb3RlLW9iai5jDQpA
QCAtMTU0LDcgKzE1NCw5IEBAIHN0YXRpYyB2b2lkIHJlbW90ZV9vYmplY3RfZmluYWxpemUoT2Jq
ZWN0ICpvYmopDQogICAgIFJlbW90ZU9iamVjdENsYXNzICprID0gUkVNT1RFX09CSkVDVF9HRVRf
Q0xBU1Mob2JqKTsNCiAgICAgUmVtb3RlT2JqZWN0ICpvID0gUkVNT1RFX09CSkVDVChvYmopOw0K
DQotICAgIGRldmljZV9saXN0ZW5lcl91bnJlZ2lzdGVyKCZvLT5saXN0ZW5lcik7DQorICAgIGlm
IChvLT5saXN0ZW5lci51bnJlYWxpemUpIHsNCisgICAgICAgIGRldmljZV9saXN0ZW5lcl91bnJl
Z2lzdGVyKCZvLT5saXN0ZW5lcik7DQorICAgIH0NCg0KICAgICBpZiAoby0+aW9jKSB7DQogICAg
ICAgICBxaW9fY2hhbm5lbF9zaHV0ZG93bihvLT5pb2MsIFFJT19DSEFOTkVMX1NIVVRET1dOX0JP
VEgsIE5VTEwpOw0KDQotLQ0KMi41NC4wDQoNCg==

--_000_IA4PR10MB8301B9F70C8CC5326A55D41090312IA4PR10MB8301namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5Pg0KPHAgc3R5bGU9ImZv
bnQtZmFtaWx5OkNhbGlicmk7Zm9udC1zaXplOjEwcHQ7Y29sb3I6IzAwMDAwMDttYXJnaW46NXB0
O2ZvbnQtc3R5bGU6bm9ybWFsO2ZvbnQtd2VpZ2h0Om5vcm1hbDt0ZXh0LWRlY29yYXRpb246bm9u
ZTsiIGFsaWduPSJMZWZ0Ij4NCkNvbmZpZGVudGlhbCAtIE9yYWNsZSBSZXN0cmljdGVkIFxJbmNs
dWRpbmcgRXh0ZXJuYWwgUmVjaXBpZW50czxicj4NCjwvcD4NCjxicj4NCjxkaXYgc3R5bGU9ImRp
cmVjdGlvbjogbHRyOyBmb250LWZhbWlseTogQXB0b3MsIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMt
c2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KPGJyPg0KPC9k
aXY+DQo8ZGl2IHN0eWxlPSJkaXJlY3Rpb246IGx0cjsgZm9udC1mYW1pbHk6IEFwdG9zLCBBcmlh
bCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwg
MCwgMCk7Ij4NCjxicj4NCjwvZGl2Pg0KPGRpdiBpZD0ibWFpbC1lZGl0b3ItcmVmZXJlbmNlLW1l
c3NhZ2UtY29udGFpbmVyIj4NCjxkaXYgY2xhc3M9Im1zLW91dGxvb2stbW9iaWxlLXJlZmVyZW5j
ZS1tZXNzYWdlIHNraXBQcm9vZmluZyI+DQo8bWV0YSBuYW1lPSJHZW5lcmF0b3IiIGNvbnRlbnQ9
Ik1pY3Jvc29mdCBFeGNoYW5nZSBTZXJ2ZXIiPg0KPC9kaXY+DQo8ZGl2IHN0eWxlPSJwYWRkaW5n
OiAzcHQgMGluIDBpbjsgYm9yZGVyLXdpZHRoOiAxcHQgbWVkaXVtIG1lZGl1bTsgYm9yZGVyLXN0
eWxlOiBzb2xpZCBub25lIG5vbmU7IGJvcmRlci1jb2xvcjogcmdiKDE4MSwgMTk2LCAyMjMpIGN1
cnJlbnRjb2xvciBjdXJyZW50Y29sb3I7Ij4NCjxkaXYgY2xhc3M9Im1zLW91dGxvb2stbW9iaWxl
LXJlZmVyZW5jZS1tZXNzYWdlIHNraXBQcm9vZmluZyIgc3R5bGU9InRleHQtYWxpZ246IGxlZnQ7
IGZvbnQtZmFtaWx5OiBBcHRvczsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogYmxhY2s7Ij4NCjxi
Pjxicj4NCjxwIHN0eWxlPSJmb250LWZhbWlseTpDYWxpYnJpO2ZvbnQtc2l6ZToxMHB0O2NvbG9y
OiMwMDAwMDA7bWFyZ2luOjVwdDtmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7
dGV4dC1kZWNvcmF0aW9uOm5vbmU7IiBhbGlnbj0iTGVmdCI+DQpDb25maWRlbnRpYWwgLSBPcmFj
bGUgUmVzdHJpY3RlZCBcSW5jbHVkaW5nIEV4dGVybmFsIFJlY2lwaWVudHM8YnI+DQo8L3A+DQpG
cm9tOiA8L2I+TWFyYy1BbmRyw6kgTHVyZWF1ICZsdDttYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5j
b20mZ3Q7PGJyPg0KPGI+RGF0ZTogPC9iPk1vbmRheSwgTWF5IDQsIDIwMjYgYXQgNzozNuKAr0FN
PGJyPg0KPGI+VG86IDwvYj5xZW11LWRldmVsQG5vbmdudS5vcmcgJmx0O3FlbXUtZGV2ZWxAbm9u
Z251Lm9yZyZndDs8YnI+DQo8Yj5DYzogPC9iPmFybWJydUByZWRoYXQuY29tICZsdDthcm1icnVA
cmVkaGF0LmNvbSZndDs7IE1hcmMtQW5kcsOpIEx1cmVhdSAmbHQ7bWFyY2FuZHJlLmx1cmVhdUBy
ZWRoYXQuY29tJmd0OzsgSmFnIFJhbWFuICZsdDtqYWcucmFtYW5Ab3JhY2xlLmNvbSZndDs8YnI+
DQo8Yj5TdWJqZWN0OiA8L2I+W1BBVENIIHYyIDExLzQ2XSBody9yZW1vdGU6IGd1YXJkIGxpc3Rl
bmVyIHVucmVnaXN0ZXIgaW4gZmluYWxpemU8YnI+DQo8YnI+DQo8L2Rpdj4NCjwvZGl2Pg0KPGRp
diBjbGFzcz0iUGxhaW5UZXh0IiBzdHlsZT0iZm9udC1zaXplOiAxMXB0OyI+R3VhcmQgdGhlIHVu
cmVnaXN0ZXIgYnkgY2hlY2tpbmcgd2hldGhlciB0aGUgbGlzdGVuZXIgY2FsbGJhY2sgd2FzPGJy
Pg0Kc2V0LCB3aGljaCBvbmx5IGhhcHBlbnMgcmlnaHQgYmVmb3JlIHJlZ2lzdHJhdGlvbi48YnI+
DQo8YnI+DQpUaGlzIGlzIHByb2JhYmx5IGJldHRlciBhZGRyZXNzZWQgYnkgJnF1b3Q7W1BBVENI
XSBxZGV2OiB0ZXN0IGlmIERldmljZUxpc3RlbmVyPGJyPg0KaXMgaW4gdXNlJnF1b3Q7LiBKdXN0
IGFkZGluZyB0aGlzIHBhdGNoIGZvciBjb21wbGV0ZW5lc3MuPGJyPg0KPGJyPg0KQ2M6IGphZy5y
YW1hbkBvcmFjbGUuY29tPGJyPg0KRml4ZXM6IGM3ZDgwYzdjMWQ5ICgmcXVvdDttdWx0aS1wcm9j
ZXNzOiBBc3NvY2lhdGUgZmQgb2YgYSBQQ0lEZXZpY2Ugd2l0aCBpdHMgb2JqZWN0JnF1b3Q7KTxi
cj4NClNpZ25lZC1vZmYtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSAmbHQ7bWFyY2FuZHJlLmx1cmVh
dUByZWRoYXQuY29tJmd0OzwvZGl2Pg0KPGRpdiBjbGFzcz0iUGxhaW5UZXh0IiBzdHlsZT0iZGly
ZWN0aW9uOiBsdHI7IGZvbnQtc2l6ZTogMTFwdDsiPjxicj4NCjwvZGl2Pg0KPGRpdiBjbGFzcz0i
UGxhaW5UZXh0IiBzdHlsZT0iZGlyZWN0aW9uOiBsdHI7IGZvbnQtc2l6ZTogMTFwdDsgY29sb3I6
IHJnYigwLCAwLCAwKTsiPg0KTG9va3MgZ29vZCB0byBtZS48L2Rpdj4NCjxkaXYgY2xhc3M9IlBs
YWluVGV4dCIgc3R5bGU9ImRpcmVjdGlvbjogbHRyOyBmb250LXNpemU6IDExcHQ7IGNvbG9yOiBy
Z2IoMCwgMCwgMCk7Ij4NCjxicj4NCjwvZGl2Pg0KPGRpdiBjbGFzcz0iUGxhaW5UZXh0IiBzdHls
ZT0iZGlyZWN0aW9uOiBsdHI7IGZvbnQtc2l6ZTogMTFwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsi
Pg0KUmV2aWV3ZWQtYnk6IEphZ2FubmF0aGFuIFJhbWFuICZsdDtqYWcucmFtYW5Ab3JhY2xlLmNv
bSZndDs8L2Rpdj4NCjxkaXYgY2xhc3M9IlBsYWluVGV4dCIgc3R5bGU9ImZvbnQtc2l6ZTogMTFw
dDsiPjxicj4NCi0tLTxicj4NCiZuYnNwO2h3L3JlbW90ZS9yZW1vdGUtb2JqLmMgfCA0ICsrKy08
YnI+DQombmJzcDsxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
PGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2h3L3JlbW90ZS9yZW1vdGUtb2JqLmMgYi9ody9yZW1v
dGUvcmVtb3RlLW9iai5jPGJyPg0KaW5kZXggODYxOTJkYzhkYWQuLjRlNzRhZTc2MTU4IDEwMDY0
NDxicj4NCi0tLSBhL2h3L3JlbW90ZS9yZW1vdGUtb2JqLmM8YnI+DQorKysgYi9ody9yZW1vdGUv
cmVtb3RlLW9iai5jPGJyPg0KQEAgLTE1NCw3ICsxNTQsOSBAQCBzdGF0aWMgdm9pZCByZW1vdGVf
b2JqZWN0X2ZpbmFsaXplKE9iamVjdCAqb2JqKTxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBSZW1vdGVPYmplY3RDbGFzcyAqayA9IFJFTU9URV9PQkpFQ1RfR0VUX0NMQVNTKG9iaik7PGJy
Pg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFJlbW90ZU9iamVjdCAqbyA9IFJFTU9URV9PQkpF
Q1Qob2JqKTs8YnI+DQombmJzcDs8YnI+DQotJm5ic3A7Jm5ic3A7Jm5ic3A7IGRldmljZV9saXN0
ZW5lcl91bnJlZ2lzdGVyKCZhbXA7by0mZ3Q7bGlzdGVuZXIpOzxicj4NCismbmJzcDsmbmJzcDsm
bmJzcDsgaWYgKG8tJmd0O2xpc3RlbmVyLnVucmVhbGl6ZSkgezxicj4NCismbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZGV2aWNlX2xpc3RlbmVyX3VucmVnaXN0ZXIo
JmFtcDtvLSZndDtsaXN0ZW5lcik7PGJyPg0KKyZuYnNwOyZuYnNwOyZuYnNwOyB9PGJyPg0KJm5i
c3A7PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChvLSZndDtpb2MpIHs8YnI+DQom
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcWlvX2NoYW5u
ZWxfc2h1dGRvd24oby0mZ3Q7aW9jLCBRSU9fQ0hBTk5FTF9TSFVURE9XTl9CT1RILCBOVUxMKTs8
YnI+DQo8YnI+DQotLTxicj4NCjIuNTQuMDxicj4NCjxicj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Jv
ZHk+DQo8L2h0bWw+DQo=

--_000_IA4PR10MB8301B9F70C8CC5326A55D41090312IA4PR10MB8301namp_--

