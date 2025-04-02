Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF14C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyEz-0000cn-0a; Wed, 02 Apr 2025 09:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyEt-0000Yk-Tv
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:34:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyEr-0007BP-Ah
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:34:43 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DN485010588;
 Wed, 2 Apr 2025 13:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=lIWoM+Xeb7tP2Bq916Ju1kmXs3m5QlVitfCfg2Il/Vg=; b=
 SNxcd6IOQ5Dsbs+M7eQZs/ul4IDUBwB/0wHD4wJU4WTfHP8hfOWmL3yH070XbBnO
 WsJecSyBiSOJYDFQ06lIom3wbQYOX1elynDmAyZ1T5e5obaC5uBi8iTbTLAU4qcu
 2IKWnhuQ5P3QMA7YpQJwXUIlPx6moEzwRGEBKjmABoLZPfy6hCpiTweEG5ZerznR
 sg+gpqXVVoQ1yentwwf7GhIpEgCtHDx9cgyQfiVXrWWxU3Wkp2+59FS1vBqSD7Uk
 kv1Ud7qJfeKiZeJe7srFf98KKP7K6V2ad//gm+jgJyGFX6aCxr5lIek6VAeXrjdY
 W9ZLDRfTPhAU0PhtKwCJPg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7satebb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:34:37 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 532DKAWJ013590; Wed, 2 Apr 2025 13:34:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45p7agwsfc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:34:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4puZdh7N+SNsL1LiUPSgmIr8Cl1aRlsE9bR8RruqMenL5tIHuwexCIbb3fNgd4MfcKe3DgnEswaBebc78+qNgSdvYAuExTQ7gh70oNvHemlKrRAjfgC4Db3o2AAnSUbODRgpqXcR9t7iwt1xinWG+kJBEHo5laFa+gaz8phkLode9GyJRY01wK0eV6uhL5lKqHsOXdaN6N0LC9bZbTZu4ID9bGhvMJ9m0ADngL2D8tM0H6X3ylijlA/0JF+wrt241HvLOEtEsjLWfSJ5Q9dSFQxBzsAA21rjqU3OsTwZ8IicdcxqpG+RjWTO2tI8IQ1q9nf6dMKd/eU+S6H6lfirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIWoM+Xeb7tP2Bq916Ju1kmXs3m5QlVitfCfg2Il/Vg=;
 b=ulNKkcW0pigxNRbb5c7qn/O68zCHo9vz0VU6zYLX/7VEiYw3A7DWPwsw81/oA1DbGAPssiiMnPHsiG2bFwOWagryYBKDybDumkrJ7IsiuvHBu9k2KlyFVmUMJhfDcRzEyTpZYAU9l/wYwx+RD+YGKprNYmx77ZYxIeu1x6/FAz6rpl3RBCCF/EYQjRzoGR+mjHiCizuDUneLmCc/Gyv0cqic3ZEwehVg+fh9sS71NcIhOAucExkIknyk8SxASltWpR5KP0AC8PKEjkrczdOkj+IBvqikVruovXaX+cJjj2FJc+yl+MzQ4B4DOu2q2IDzREi3AaRXj2tMESmf3+RHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIWoM+Xeb7tP2Bq916Ju1kmXs3m5QlVitfCfg2Il/Vg=;
 b=A+fsFKjYucUW1Qr3KNaihCd+0YUtg7ycKj1fi8skKhp6U7d1Q0rc/yjzCfhKG7bksBxbr8nQApC+XF6vFFK59NUMSouBEf7aHyvNLGvZ2PNlW0rV1KMQ6sBNz3mY7sj3PHEcw7Ueo4sU/90VRnYpJ4ENwznUEi+CA13d2GtpIxA=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ5PPFB3F166793.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7c4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.37; Wed, 2 Apr
 2025 13:34:35 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8583.033; Wed, 2 Apr 2025
 13:34:34 +0000
Message-ID: <92f88380-3df0-4a64-8544-389199ead6a1@oracle.com>
Date: Wed, 2 Apr 2025 14:34:30 +0100
Subject: Re: [PATCH for-10.1 v2 28/37] vfio: Make
 vfio_container_query_dirty_bitmap() static
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-29-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250326075122.1299361-29-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0172.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::41) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ5PPFB3F166793:EE_
X-MS-Office365-Filtering-Correlation-Id: b04e863f-3dac-48c5-77bf-08dd71eb1b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2tJTDVnUFg3bkJjSW5Fc2Rua3NGQ2x1eEI1N0NHZXBlZjYzTXJ4ZXVCR1dN?=
 =?utf-8?B?amptZEpEMnF5Rll1V2hwNVlkblRRQ29LZTFVelp0V21seXRqTmxCMUpCZEZS?=
 =?utf-8?B?OGsrK202OWR5SitleGZENnRHMVBUSlRNZ01EODIwUU1VZ2lnWU5ua29WU2NI?=
 =?utf-8?B?eDdLYnJEZXVoREg4VVJJZTNKYXFaT3pkeVd3N1M0MDNyYkx6MW1wcmR1TGRH?=
 =?utf-8?B?N25BL0hBaElOblN4MXRWeFhlVHpyaDBhNlpjdy9SZ1JacFpwTzU0NmZnelNJ?=
 =?utf-8?B?VkNDK0M1V0l1ZlBDNms5blllRjRDSlZ4NDFXTWl4SENFUSsrSGxHVVdsV0Q0?=
 =?utf-8?B?RGw2dS9WZmRZa0FuZFNSSnRrU004Sy9GL0NqOENlY29YR3VCb3JYWTV4cG9w?=
 =?utf-8?B?NUdLbEJsQWxmazJZRE5JYURCOExBRTRGQXphdFFaWTROMDZjS2dtQWM1L1I5?=
 =?utf-8?B?bjVabm1ZT2ZETDZKbmVpMjl2MWlyaHRpWDE2Yi9qRm9BcXhESVdNZ2t2TEl4?=
 =?utf-8?B?THNtUzNjOU9ETU5jOXlhd3RvUHdhR0dBWU84MFJiQ3ptUGN4a3hiQVNqUHJt?=
 =?utf-8?B?NkVVZE1LME5VMUVYMWhMaktYKzhGeFh5U3VPV01xREFIWDYxcE5YZ21LZkJh?=
 =?utf-8?B?TVV0Ukt1ZHhVaUpyK2tHQkpOT3EvbEZJZFcyaXo2NW9uUXIvN3NSREh1RW0z?=
 =?utf-8?B?bkhvdmp3WEUwNlE1MllSOVBwVG5ramFNcHVUWFlxaU1leUJraWVlcEVScWFP?=
 =?utf-8?B?QWE5T2UwME5DTUdDMVBsTzc1dEZiTGpWeVNkNmdMNFA2V2hBOEtTOFQ3dFU3?=
 =?utf-8?B?dG5GSjgycWd2dXRDczlOa2xpN21oaHdrbVFaKzg0U29PcFpHUjJONXl6SlRw?=
 =?utf-8?B?akhmQnZpN2tKWjB6Z0lqZndMZ3A5SXJyMnlmZzJ1THB2NVZiaG8wRy9jclRo?=
 =?utf-8?B?T0phT09QYThWNGVnMDZOVjRwSDFpQ01paWh0YktIY0ZpWitOUzY1OCt4WWNp?=
 =?utf-8?B?WmJLdTBjRzhRRnBwZW5WdG1OenhQYlhjRVRvbHNLWnBNU3Z1cG81OGM3YVh5?=
 =?utf-8?B?alp2dGtCS3U3SG91N1Ztdnl3eWYvZnNPd2JHbmMrQ2R1UHEzbGR4SC9FUld6?=
 =?utf-8?B?Y3VGMDBmcWV0ZVl4Mm1yZjJ4bGw2dGFyOXl3M3YrdVhueHJtYWcvcnFOcjFx?=
 =?utf-8?B?Wk0rRFhGQ1lWSVYyTTFiTk1YeWFwT211L2RqNUVqODhMeHNTNWhFQ1RvUVVm?=
 =?utf-8?B?VkdhbjhhdE5NRGxsYittSStUcUNrKzdQQ2crVkE0ODhhMUw5MlY5aFFCOTly?=
 =?utf-8?B?RHBoMjBWd3JHcFplc29GQ0ZNY2Z5b1ZaYVlNci9wQzVnL3F4MEYrNmxyWVZw?=
 =?utf-8?B?NHJiMlUxcFRaVGtUUzVrTXdETTY4ajVRSU5rYnByR2dJRHVWaTZ5aEt5VHFl?=
 =?utf-8?B?OENXTGFadzhkTkhoVkxOeDBWa2JaT1B4eStHMFpoZlordFRZK0VIcGtwbHJY?=
 =?utf-8?B?QnNrV0lKOWtjeGNLWFlkSFNWUE5NNGRuWmFlSGlNbDh1UnZEZTBjMmo2a0du?=
 =?utf-8?B?RjRHY0VRTTFKa2h2SXJJV0lKS3czYlZNRkY1bXhqeWFQQUdLaDVqVGZZblhM?=
 =?utf-8?B?Y3BTUjRsZGkwbHd4amk0OHhxNnRJUUtVNDMyc3lVajZzZlpPMUNvWjRvckJ4?=
 =?utf-8?B?dDIxNGszeFpUV1NPell4amtvalR4eEpzYUlrV3RSbWtGa2lRYUpSVURMZFNw?=
 =?utf-8?B?bk1CRTdOYU54ZGFxNHo5TVBubEFSbThwMFZOakVrd3NXRG4wMTY0eVNqc05Z?=
 =?utf-8?B?WFNnNW9LRUVKSVFjaUVPMTcrUE5JdDFVTlc2bGRCY3NWZDZsZ0hCalVRTjVl?=
 =?utf-8?Q?vNXWvUezIAMsr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azBVTys4dVhPVkxHdE1pTXhRWEI0TUJVbkRTakNBS2hCK1p3UTlVdEZhTExU?=
 =?utf-8?B?V3J6cXBPT0d5R1RXTXhzT1daMitEdDhuZ1pBNXVLWTI5TDRHK3dLK01DRExr?=
 =?utf-8?B?eWI5bXdnc1lVZ3IyU2lLZWRVWFk0RkpPWWRGNm05ZitxL3FTQS9UQkwxb2dB?=
 =?utf-8?B?clpPVCsxbEhrZkxWemVlWFdSYTJTb1RiRUswNHowWk56TnZwV3BZV2VwbTQw?=
 =?utf-8?B?cVA0UWNqeDc1ekR4TEppNWE4dm1YK1NCdStab3RtK3hDeXJLcHQrejNrZktX?=
 =?utf-8?B?SjR5SG9jY3c5Sk1vZUo3aTJuemc0QzlBak9MMXhzVG9qTm53UkxGUnFaWVZK?=
 =?utf-8?B?TGl0K056cW5wajNBb3ZhSzZrMzlsaW42VE16OTQvclFnQmYwVXB4bkhObVJz?=
 =?utf-8?B?Ny84YVBDTjhzKzNISnJFbWd1U2xnaEJoU0FPWmI3cTFJNy9UbDU0Z1Z0cHFY?=
 =?utf-8?B?bzdjRnBtN21GTkV2U3VheDVPTWZqcS9tRER1bXA3VjlSZ25PT1poSkN1bThW?=
 =?utf-8?B?Y3J1RnZZRElCeVJpUDBEOWluN216bHFKd2NwbUdMUHpRdGJCU3hhOFdZVVpB?=
 =?utf-8?B?U0YzSTZmK3lKVlJyTmVjMkRoakxIMEprUWt0eUtwZ0pCU3FmeVlQUEhyNkh6?=
 =?utf-8?B?c2pIMkVMNkg4WWQ4VFoxdkxDczBCbEIydmY3RFFzb3N3b0o4U291bWhzMUQ2?=
 =?utf-8?B?NlFTMlVSSzdGT1lDZ09JR1pTdXJSUTFrekFhd1BqdEdHWncvdkFiWktha2Rv?=
 =?utf-8?B?WEttZis3bGdIT3dnTjZPTEdvaGd1UThFMGdtMGNNUlBlTnZFS284T2FOQ0ow?=
 =?utf-8?B?cm9VK0I5cnVROW83bU42RkRINm5oWDBLL1dUVGJ0S0p5MG5vbVRVeWsvVmls?=
 =?utf-8?B?ZHFWQ1YzOHY2eSswa2tPaWZTRmcwUlFqQ3hrdktYbGg4RWJtWXNjcmJuelNm?=
 =?utf-8?B?ZllNMXNtTWhlWkdwcnZJTFROeWdKTDVWVGRFSmxRSkIxcGp2anJmNWJoajh4?=
 =?utf-8?B?MGYvZzVPWVRnc2FGZzNpc1puOEhXMFErQml4OEpCQURUMDZmT2VIWlZlMW5i?=
 =?utf-8?B?b2tkMVcwWXA3WElXMjlnNStaeTdjeGpXekxkWk9FdVRUVE1iUVI4WG56cTFy?=
 =?utf-8?B?VlBOckZvSUdpczBBZHpNZkIzVy85NGFGMzR5K3J5YXU3OE41ZEtUd2NZQW1E?=
 =?utf-8?B?Z3lSU3RIb1gxTVhERDQ3WWJva3BtejFHdlBqcEpPZnBjTUY0bUZ4NEc3Ri9a?=
 =?utf-8?B?NUhMNHBjdndKa3pFTk5PbnFQQzZ6cDRiN2xReE1SWFhQQUFqblR1dUR5M1ZV?=
 =?utf-8?B?UmErNmw5WTBlQ2V3S2VXa0luWEpEL29TbFBISTZqVFVZckx6ZUhMOFRiUkVH?=
 =?utf-8?B?STNUcGlQd0xGWWJUSndRNGJ0YmQ0cDYyL2xnKytadWJpUG9HbzJxZE9YZ0lq?=
 =?utf-8?B?b0tReVhLNFZHY3Y5VTlLTWU3dlAzck13UWs2N2N1ZTJHb3VtcDl6YzhHUGlL?=
 =?utf-8?B?ZjgrRjNza0Z1aE92cEJhY2JybDJTc1p1Tld6azRsbmtkMHZDLzJ3dDdRaXRw?=
 =?utf-8?B?OE92cTdTdUZvQXBKcmRGK2lHemxmU21pZCtmaVZobkx1Z2F2aXpIYTFLZUFM?=
 =?utf-8?B?NVN6NXkvaWR5dExCYVdnQ1k0QXYxWjZKM0g2M3g0Y3Jna1VsV0lVamcvTDdO?=
 =?utf-8?B?QVA3NHRTdkZhcHM4TkJVUVVBQU1WQ1NQTzM2V0xXbTJ2cTlVTEdsMHBYR0wv?=
 =?utf-8?B?NHpyVXVHMnUwNHlEaTg0K1BTb1JTa05lZVNERGVUenpxUFNCYmZUMFd5cWdH?=
 =?utf-8?B?M1dJZHNVQ0NML2VSQTFmM05USnRnMUdyTmtSSVBOV280R0x0dHRhZmptaW52?=
 =?utf-8?B?OTd5WldVQ0xFb3hTZHVOdHY1dUttbGtOV1ZhcDJsVTlmM1U3S1hwYzQxbUxL?=
 =?utf-8?B?YVBva1ZCRElUelRnYnhpSG1XTi9xMmJXa2tMa3RIVjFaQUt6RTVqc1VXVU5I?=
 =?utf-8?B?T2F5Q096Q1NjcUJJdENnMnZFM3htNG1mMzY4OHFUUGpRWGNFV3RXWXhHUS85?=
 =?utf-8?B?cWpCcGdMWUtoaGxJOW1aYXNVaVlrUzdxSUNzdWFzQmhLcGgzdmtRWUMwZTkx?=
 =?utf-8?B?QmtGVnN2aEVYdzgxZnE2R3BXT0lMLzR2aEh1QkVYbDRUTW80Mkw5VGM1Q0xn?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MU7iICAvS3KMRLzDLEhR1aOoSFyvto6loocAtUIFiMoJVeq1dcZE5eZZr4L0Ch1bvR4gqEW2sUiGAqxCN9Jcu+CeRc3ZrcKD3Rs6m45mxdGA+9HRXPzLS6g6YWNXlp8UFOj8w9HxtCGd4ziVvliOLA3jzQ9kBzDrmFCsFZBN5K6Gv9EuGhcC/G7RjJqzJnxUT8ZaQw6p0zJnx9AigZdMpaurpkyT2RRc2bvaHWjq1D49R1Mw6BIFms1tHdXWolR18Ep7KntqiD4ywUPTp+SLWjEW+ayHnLNIGyjjffR9K3if13jbKQd5yY9YuWNObg24Cx0k/rNeHpCBL7WhkOss8hzHw/PXN9akZOkit0CITJbtPyhy1xnSazw+W58z8RcQatILANfVTJJQa7VE2dNkkWwWQi5CNMrXnq9+qyR129MDaGeaZYGTHlLfgIUTFID6fgpab1G2tork1pJ9tPSBYzPQ6n6iYXvCBwYWLbH/Z8OpdZvov7ilIkj9WOXf/0vS3iEDw8QUplHh8hsZpwm33NlbF8amoHSmadiqdlIoCXln4WQssM5kVyCwLb+U/1mb3ivZjDR5/3cgl2K0HF4e5uAoWZh6qcIcMO2f3VPK5+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04e863f-3dac-48c5-77bf-08dd71eb1b11
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:34:34.6364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWdkc/O+C1qpJgd2bZ1UjyMvte5Awxixjhl0wjelikbef2BwhGsp2oAK9+DSZ/bVH8l3+WXg8SU+WECD1GEwdOP5rPXfkJJcD/Y73gR0duA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB3F166793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504020086
X-Proofpoint-GUID: _XFXm1QJyChs8bnGsTOC9SXeWdI2ns4J
X-Proofpoint-ORIG-GUID: _XFXm1QJyChs8bnGsTOC9SXeWdI2ns4J
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 26/03/2025 07:51, Cédric Le Goater wrote:
> vfio_container_query_dirty_bitmap() is only used in "container-base.c".
> Also, rename to vfio_container_vioc_query_dirty_bitmap() to reflect it
> is using the VFIO IOMMU backend device ->query_dirty_bitmap() handler.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

I would just call it:

	vfio_container_iommu_query_dirty_bitmap

That holds better as one queries devices the other queries the container iommu
backend. 'vioc' sort of leaks type definition unnecessarily which seems to go
against the generally naming style

With that:

	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

  Joao

> ---
>  include/hw/vfio/vfio-container-base.h |  2 --
>  hw/vfio/container-base.c              | 24 ++++++++++++------------
>  2 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 1227771dd896b5917366ef578109b0ad92da2375..04c87fe48bed75aa281a13f75a36e345036a9163 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -89,8 +89,6 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>                                         MemoryRegionSection *section);
>  int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>                                             bool start, Error **errp);
> -int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> -                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>  bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
>  bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>  int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 4edbd39185375dee42ee6e6410da7b94635b5ab8..7f11aad339e713ea09123f361425370d87762950 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -141,16 +141,6 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>      return ret;
>  }
>  
> -int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> -                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
> -{
> -    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> -
> -    g_assert(vioc->query_dirty_bitmap);
> -    return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size,
> -                                               errp);
> -}
> -
>  static bool vfio_devices_all_device_dirty_tracking_started(
>      const VFIOContainerBase *bcontainer)
>  {
> @@ -214,6 +204,16 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>      return 0;
>  }
>  
> +static int vfio_container_vioc_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
> +{
> +    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +
> +    g_assert(vioc->query_dirty_bitmap);
> +    return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size,
> +                                               errp);
> +}
> +
>  static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
>  {
> @@ -263,8 +263,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>          ret = vfio_container_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
>                                                          errp);
>      } else {
> -        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> -                                                errp);
> +        ret = vfio_container_vioc_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> +                                                     errp);
>      }
>  
>      if (ret) {


