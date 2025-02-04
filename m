Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724B0C02198
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMwa-0001t3-Vi; Tue, 04 Feb 2025 12:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfMwW-0001p0-PW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:42:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfMwU-00007o-Uh
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:42:36 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514HBqKV001595;
 Tue, 4 Feb 2025 17:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=bqCDEXFPWvelAX1nckdUOzXnnl4chSoFWDLyCiWpq5E=; b=
 Pv3Gf+C/xNzuxeKp0TSEx0nb4q8h8PCAFMKuJGhZmGiEtteA0sk/Jgd3aDNFQQN1
 2rppQwvha0SnnakINlMvE+v4GrQnIijS9p34Bwb/2X3PVFD9UB+nnIwyg1W3Fzmw
 eku7DIt5SKdatU0AMHGUX/P3u5hJ2HCZYrK4tg2lvvqz6MGCqRVtRNL2qQVCdfA6
 poYiguiWlmLXxI7SwQBOuBGJcBFcUvmjsL8NoAsSFRUsAbD8KJkfX5LSaNJ8oK0m
 q0CKUioIYh3ElOiK657pAD553Ec7DqR8o4TxYt4myG6n22OAcGIgIUgR31j+Dy3y
 2X2IMGHOzXJ9ZnCgmR+Igw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4rkes-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 17:42:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 514GfFJ3004903; Tue, 4 Feb 2025 17:42:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8fpabv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 17:42:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gebh/+R24A15QtAYK4pp0o4xmkg7SsvgbKFmiE8ybjOWe80PBOA6bV6pIA9VZDOGrOQ2JYDejbqf0/05bJ5Z/X6qLFEPU/8anXU0imG4mudpZKVAdoVnfpZOwDvoCo0mQrRwy/S6DNGTSH2wOxArnPxPDonhkj9A3ORRmrwBrZwWX6YrNQlrnXeUN9w5EU4uF1Q1tAB8RbXTYVN4Epfc/EDv9uIjBn6gyqU4Dm+UMoKD5AVMYMiQaTyiB7YZLTSlWhjsIU1hfIqOMHr5F+lq333Q9YYPc/XwNXUU2CbtlLuI5tgsF4ZDnfTiWfdiicc6ID2AMcTjM9NIwxLeLG34PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqCDEXFPWvelAX1nckdUOzXnnl4chSoFWDLyCiWpq5E=;
 b=j0zLP1hjvXhwFYzfy6kdqCwVUBtOGz0p0M16vrp0ndFY9gp+mly5VhBJiJbVhFurVGlV9wXwyU2Sueq1AbZhAJRz1HYOS31vXZth827+8RyxC9fzvQ1PwoDt/BM28H2mqmAJ/VdsYjtPVAu7tKt+414Og3R5zh9je157kJeWTAYn2wfDtopz/aAN/F3CD9RXq+EUCtH0hSeCP31qgb4ShjUqj2/D+yM0l3lbk3pWjNrmJpW7GXmDngmL3+RPGEU4OJKJ3EYiyJYJH5tOrTU86/IEzL9XvQrGMMd2feFVPsDq6Z11jW9+JqjmrfifHjhN7tkaBp1qc9OaPjD+9NZQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqCDEXFPWvelAX1nckdUOzXnnl4chSoFWDLyCiWpq5E=;
 b=h0eYSJlqmFJK57ibIW3PScIXg/dG/GX5oQ4pqg3scf+WPA/YIwqtTAHl4V+iScyc2aj3ZFOCLQpbfeFXTNQirQidMDtAVleoBIpStsr3tQur+BJJ6U/aqFDKUNrinEyHKrEDsuHsnzsTwDISbXtKP0vBD+GaJ5rA7yhNfD60aNY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA2PR10MB4474.namprd10.prod.outlook.com (2603:10b6:806:11b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Tue, 4 Feb
 2025 17:42:27 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 17:42:27 +0000
Message-ID: <9a9a69bf-3bae-40cc-876a-c54813365577@oracle.com>
Date: Tue, 4 Feb 2025 12:42:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 18/26] vfio/iommufd: define iommufd_cdev_make_hwpt
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-19-git-send-email-steven.sistare@oracle.com>
 <b17064fb-20d5-4879-a4bf-aa57904b2272@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <b17064fb-20d5-4879-a4bf-aa57904b2272@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:408:d4::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA2PR10MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f73617-6af4-4ee2-6bde-08dd45434ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RCtGY3E4WUtWWDZiR2dvRjdwMFRTSXY0NGlWaGlKaE1xakM3SVgrMjR0bW1k?=
 =?utf-8?B?SzhqWURUMTVXOHdaT2xOZHc0bVlQSTFjTTFHTkZiZFRZYzFjdXJHeGFXaW5T?=
 =?utf-8?B?LysrWTNmdC9iZVRhM2w4MDhwMUpsM3djWTFNRFphQnZla2UzY0xOSHZlMm9q?=
 =?utf-8?B?NUFIYVRXc3R1cjl6SzNYaTFxU29zaHBJMjBPTWFDcFdUNE8vM1BhVmRjYVI4?=
 =?utf-8?B?TDFzT0pjTkFQZWZCK0I4NnlPRDc3QUVGalliR0VHT2wyN2JsRmZHQ0d4Uk9H?=
 =?utf-8?B?QUdZTkpRak5rVlFmSVRuUWE1Y2ZLQlFOY0d6elVEUnZTQkdZaFlBcEJlTTdm?=
 =?utf-8?B?bXhvT04xYVZ4Z2h0MHcrUEtvb3VXb0p3VG1MZzVmVUdrNzFXcHJ4Q0FXQ3BJ?=
 =?utf-8?B?T3NhbnNjakFuMlgxN3FVRWZkS1BiaGh0ZWM0MXBWaEw2UTU3Z292UlhPNTZG?=
 =?utf-8?B?ZEhSZTZuV2ZVcVNWZE5COEpHWGZsanAxcHJNaVBYbkdUL1paejlYd3VEQWFL?=
 =?utf-8?B?VHB4SnRxWW54aUphZTFIcWVRd1pnUXZxSStxUzh6eUJ0ZUZIcC9NUkxoNG4z?=
 =?utf-8?B?L204Z3JBelBEV1NXd0N0aURsTFBPbnZpMDZCQVRvQmw0eTljT1dtQVpDTXVi?=
 =?utf-8?B?NERQM0grMTRKelR3NWs1dHRsL0ZFT3FpV2pzMGY4ZEJOc2VpemtIY1hpZ1Rm?=
 =?utf-8?B?OU15WGMyTzRxRTJ1Q1lITUlsY1VsU2JUZVUxeWJadGRtUlpmY2tXTHpFYUVC?=
 =?utf-8?B?VC8vZmErYzFEWU9hdXFLd3VUZHlkUFRTRVFPMmJ4bXZ5bHlDNDR2L0hocnFs?=
 =?utf-8?B?TW5aN21QK1l2cjl3ZlRvOTJkTTNpQ3BVendCdzBHcXdlb3l2SEV0dHh4L2xz?=
 =?utf-8?B?TUc2cW9sTGwvMUhwQjRpMjlyYUNnTFRRTFQ2Y0dNRlczMU1LWWNtQlpTUnNL?=
 =?utf-8?B?MTg1OEcveE55cnJ5eG13ZXl0VFFQNUlvQkJ2cXJmd05VaHJaUzkya3oxN2g3?=
 =?utf-8?B?ejgxMzlYQlFUL0FhVU11YTkwMGtiRWpsQ3g2REZSUnpPemlJdkk4eWtwSVpM?=
 =?utf-8?B?c0RNNmdEOGVlOEx3WkpGcXdQVVBzOVFiNURUSEMzSEpPMFRZU04vWXA4ei95?=
 =?utf-8?B?dDI4QXN1V1FuSEV4Rzh3ZVduTGk2Q2pmdkIvSG1BcVZLZzJUOVZXbDlsVWhD?=
 =?utf-8?B?NXhHbVFuRldxa01udUZkNFk2akRXRE15VEJhTUR0VE9rS1VpaDV0YzBRRDBT?=
 =?utf-8?B?RS83TGRsdzA4ZWI1RzVlZzVEQUxXdk94anpCKzVWTzlIc1NkaFVlSkxHcGVs?=
 =?utf-8?B?N1RKeUVzcFdOUXlqYkRJeGpiaU83dzg4ak8zQlRJV0NiT3BOekhxOXVBOXZa?=
 =?utf-8?B?N2ZoOE1vd09pU0xHdVlDMGl5QllkQWE2YXBXYms4bDlGTktSVG8vdHR3Zzlt?=
 =?utf-8?B?VEpzRlJLL1N5R0hPSWpkQysrdmdodHJZWGJwTjhhc3grcE1jTVJ3R21zWUYw?=
 =?utf-8?B?cVRoK2tiN2lJa3VtNnM2WTkrcFdpU3htc1JaUkRFZDgzUUhTcWFIa3VvZklB?=
 =?utf-8?B?cGZKaVZvQUo3cWh6OG9pMS9Oa2tjN3ZUaGE5WndUTndvSGFvL3JhblVsOHla?=
 =?utf-8?B?ek50NmZnQmcrRCtxeGx0aE5Gamtibk5NM1JneXBHTVhvbitPZTRNcldoQy9W?=
 =?utf-8?B?Z28xa2FMS0hwYjVuOXI4bi8zZ1FRQk1tQ0d5T0dKZEFWMWtSNWlGY2JRS09p?=
 =?utf-8?B?cWNqaE9iRUpRMFdISVpUbko4L3diSW9NZWc0NWZrU1lGS3dGTlB1TFB1Nmgr?=
 =?utf-8?B?c1lob01mWk8wMGxyekRlb2NxTEo2eEs4L3NDUWxWdXlOVmtFZ3FMZElYYW43?=
 =?utf-8?Q?FFS+z1IbW0rj8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0l3TXZUWXB4RFc3a1lUZXNiNUJTeTlMeEFFaTdHQytXWHZyTnZ0R0FSeGJE?=
 =?utf-8?B?d00wa1JWbGgweUYxeU5ZaTdJcEJsTFFjSlNaVkxwRHBBZzUzeGUxVGZVRCtx?=
 =?utf-8?B?SW5Pdy9JTmsxS3pCMWFyaDdGMEJ0Tk1pUk9uaHlUNDNDL1cvbkFxcVNhVnJ5?=
 =?utf-8?B?amE1RGtoTFgwZ0tuK1NYR3hOVDhHMXdmOGVoWDV2SGRWTE9XN3YxTmVBYUtn?=
 =?utf-8?B?TzBXV2Y5NzNNcXpUeGxaeFhLUk9zcnZkRUZLcnNMWjB6V1l6QWo2MERMK3h2?=
 =?utf-8?B?c1VVaksrWDVnODl1RXVsaitSaUpwZkdOUjU0ZlFkSks0aWlJY0lQRkFYdVNK?=
 =?utf-8?B?UVQ0Rlp2V1RhdVVrWW51UzhSL1lrTURONGFhaXB0MHdxc2tKK2pVbkNxd1du?=
 =?utf-8?B?cm5PTG5aT09VZFpYS0NSQTdrd2ZLaGRjek5lRjczZGNYcUZqeHVkYUN2OUZD?=
 =?utf-8?B?dFhidlIvbDdYWDVDQUw3ZzJuWjRFU2N4eSsvM255dkt5TjlDelFycndBMm0z?=
 =?utf-8?B?RGR4cUhNVXJzQ0xYZUkxY00yWlRaTmU3cEcwRHFWZmxzTFhrMUk0cGJlOGgz?=
 =?utf-8?B?YVhjZHhEUzJrREhibHhGaFYvRGF6Rnc1a01hOENHZURqWUN5RU0yZVZzM0tD?=
 =?utf-8?B?YkRWS2kvT25XTjJyc21IUVN6c05FLzJ1cldpVmRZNU4zdVVTb2YvOTIvclN1?=
 =?utf-8?B?dlFtUS9uK0hTZFB0QnIzZExObC9JT1RBYzRCeXA2TFh1N0VQM05QNnlTbkZE?=
 =?utf-8?B?emU4Sm9NVnJmR0ZrWGUyWGN1TFNHNllYT1AwUzh6b1EyaVp6Zm9IK0FmQzNV?=
 =?utf-8?B?Nzc3eW5WWUFQamVHczdnUm5ZeHZsS1F0ZldHK1Zlb2xtbkxJSTZzN0V1SzRy?=
 =?utf-8?B?c1M2REYyanpBS3NWV1h1M0ZZR1hnUkdqT0FUTUUycUhLR1E2S29kY05rcXZa?=
 =?utf-8?B?cWtaUXpsWkFHbDJTcUtDRDhCaFc4dCtEckJrbkhzK2RpRGx6UDZmZ0wvbThQ?=
 =?utf-8?B?bVJkU3IrWWxiTTI3ZEl5VW5DUDQrZndwL0dxS3lEVTF3RDBNcW40WnFzZ1pp?=
 =?utf-8?B?bWxOZUVOOEYyMUcyNUVrTEh1YTg3dnpDNmRhU0NLQzhHMEJpUEkwdGR6RHZz?=
 =?utf-8?B?Q3ZKR0wyRkt1ZlltMFloYjNCZEUzc0VoUEI5aEZBSXpsS1V6eGMzWVRnd2Fi?=
 =?utf-8?B?Z2taS2FxWGwxS3YxeERtTlNHZTk3U1dacmJSaVp3djIzSzVhL0lWa2V3MlZX?=
 =?utf-8?B?QVR0empLMnJvOXVxRGpYOWxEVlBzczRVaGtlN0p4Q3orbEo2dldaTm4vSU8v?=
 =?utf-8?B?WWxUZnBUV2JackdnWkhvT2h6UnErQXB5clByZE40aTBtc0NKeHZvU1NPSXFF?=
 =?utf-8?B?RFNUd0ZJU3lJWnA5alZmaUNqT2UrbGNSWW1WVVJheWttdzVPS0plWG9rckRO?=
 =?utf-8?B?aitpdDA0UGdhYkk5OFErZE9tR0RlTkVaa3h6bmMyWW9jV0d0QXVtU0Jyc2NM?=
 =?utf-8?B?RnNVd2t2MXM5eWRiUmdGOVJwQWE0VE1OcUsyc1ROSHpDK0I4TWNRbklEdG8z?=
 =?utf-8?B?byt4aHlXM0pWWk1CZmFVV0MxV3ovZEdCclpJT052S2liVWZQaDV1UVJHVUR1?=
 =?utf-8?B?Y0t1UFYvK2hScExDdUQ2dGVyM0RFK2VLSzV3cklLQkJhcmwzNlFJNEtnQmpC?=
 =?utf-8?B?RTdjcXpSNVNhZWVxZ0dqdkh6SFM5eUErWVE5NTh0VHlIeGRXR1dvOGxwVFJJ?=
 =?utf-8?B?QjZldVN5dDFxVUVPMEFEcHVPcFB3MzRxMFJZUFVPa3RIaUY4Yy9xSkpKcFNv?=
 =?utf-8?B?Q0tOSG9kV2pWeE91TVVXVGYvVW0yclZCQVhlWkhNeWNIUiszbGp5UEwxZnE3?=
 =?utf-8?B?OExNakdHTXk3MUZOQ2lCeXNCT1E2NmkvVVNkNkxESFN0dzEzNWR0V1UyVFI3?=
 =?utf-8?B?cFR0bzcrSUxYenUvT21SblgrSU5lL1g0L0NSbnR0d0ZSVmRaL3JWMW0zU0JN?=
 =?utf-8?B?S0NmWDFWNjcrTUhjUlJqVFFFaDdpU2xHekZEbHBGcFZ1UVJTeFdUQWJXamRz?=
 =?utf-8?B?K1lhUHZEMFpKeTYwNGQycnJPU29PUm9tM3RjYmlPYlllTUFta2pCcjBkaFZl?=
 =?utf-8?B?eldQY1lzWG4zRFg2UXlEQ1JhdDQ1WjE1S1crNlpTeVk3ZWRxOXZxZDRXZmNF?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zIvTQxVmGw2L5s6JauEq59C8fmCaTvaHRl1SXZ6sl2jYV45p577OjYfnFh0J4yWD9snVwBhV8EqYB8I678nVIRbB6NvWtkw0j9LelZ5hqU/gxFZJSpftXVVJRSlfa7EYVXI+5Aqd2UfR4RitvE8+cyArbi30Ag8K+KlbsEcVrcBZfmm1xHuMIocBz3vuxqbaF+Ji5bR52Tro8c+6+ll2jOyR7DCUYNjgFY9Pq7M+4GOadDS6NGfkq6l/kWq4GN024sYBHX4ZStySgpmqEv+fA9mBujAEsT/9x2BmvUSIx+Jg+wYYlDk727M7+fL3IFy/vhArjhFAaleWtd68m87moYyE+YBgSPUliQPe8QSuzxJZDsKCuThMX+GOJTxv4znL8t50PumckCdMgL10ECLnLjRoJpqDbl0dNpMOzf7m8zBSEEivUHVi3x+2aTHTShfc0F3v01xrgCaisWdJPcxnsKKcVfJQTkuEW/g89LNNk4KNXpKggaMz9CMEebHAQE958qQJx9JgimTNKfj8xOZWahS0Da++mcf7i8kR9BRMfzyzwtMT4h7bUp/hq0mF92mZkPhpO0QsV2IJx/7/rQq14Iq5eHiStNtFZhBSN4mZtvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f73617-6af4-4ee2-6bde-08dd45434ad5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 17:42:27.8279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LriJiYs49wUJDy20QWHCxAAiOQbR+9F6U8ShSyoR3VJel5BEt+DgXXPSJVBDm91LBtlDqNyBVNghL+US6uLm7u5JgMRiVp48p5q3MSsv7A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4474
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040135
X-Proofpoint-GUID: OP0XaPfRmppc_hcAoiSc_pji8lEtPcpE
X-Proofpoint-ORIG-GUID: OP0XaPfRmppc_hcAoiSc_pji8lEtPcpE
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

On 2/4/2025 11:22 AM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> Refactor and define iommufd_cdev_make_hwpt, to be called by CPR in a
>> a later patch.  No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/iommufd.c | 69 +++++++++++++++++++++++++++++++++----------------------
>>   1 file changed, 41 insertions(+), 28 deletions(-)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 3490a8f..42ba63f 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -275,6 +275,41 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>       return true;
>>   }
>> +static void iommufd_cdev_set_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt *hwpt)
>> +{
>> +    vbasedev->hwpt = hwpt;
>> +    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> +}
>> +
>> +static VFIOIOASHwpt *iommufd_cdev_make_hwpt(VFIODevice *vbasedev,
>> +                                            VFIOIOMMUFDContainer *container,
>> +                                            uint32_t hwpt_id)
>> +{
>> +    VFIOIOASHwpt *hwpt = g_malloc0(sizeof(*hwpt));
>> +    uint32_t flags = 0;
>> +
>> +    /*
>> +     * This is quite early and VFIO Migration state isn't yet fully
>> +     * initialized, thus rely only on IOMMU hardware capabilities as to
>> +     * whether IOMMU dirty tracking is going to be requested. Later
>> +     * vfio_migration_realize() may decide to use VF dirty tracking
>> +     * instead.
>> +     */
>> +    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +    }
>> +
>> +    hwpt->hwpt_id = hwpt_id;
>> +    hwpt->hwpt_flags = flags;
>> +    QLIST_INIT(&hwpt->device_list);
>> +
>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> +    container->bcontainer.dirty_pages_supported |=
>> +                                vbasedev->iommu_dirty_tracking;
>> +    return hwpt;
>> +}
>> +
>>   static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>                                            VFIOIOMMUFDContainer *container,
>>                                            Error **errp)
>> @@ -304,24 +339,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>               return false;
>>           } else {
>> -            vbasedev->hwpt = hwpt;
>> -            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> -            vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>> +            iommufd_cdev_set_hwpt(vbasedev, hwpt);
>>               return true;
>>           }
>>       }
>> -    /*
>> -     * This is quite early and VFIO Migration state isn't yet fully
>> -     * initialized, thus rely only on IOMMU hardware capabilities as to
>> -     * whether IOMMU dirty tracking is going to be requested. Later
>> -     * vfio_migration_realize() may decide to use VF dirty tracking
>> -     * instead.
>> -     */
>> -    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>> -        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> -    }
>>
> 
> AFAICT, iommufd_backend_alloc_hwpt() below needs the flag value.

Good catch, that's a bug, will fix.

- Steve

>>       if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>                                       container->ioas_id, flags,
>>                                       IOMMU_HWPT_DATA_NONE, 0, NULL,
>> @@ -329,24 +351,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>           return false;
>>       }
>> -    hwpt = g_malloc0(sizeof(*hwpt));
>> -    hwpt->hwpt_id = hwpt_id;
>> -    hwpt->hwpt_flags = flags;
>> -    QLIST_INIT(&hwpt->device_list);
>> -
>> -    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
>>       if (ret) {
>> -        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>> -        g_free(hwpt);
>> +        iommufd_backend_free_id(container->be, hwpt_id);
>>           return false;
>>       }
>> -    vbasedev->hwpt = hwpt;
>> -    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>> -    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> -    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> -    container->bcontainer.dirty_pages_supported |=
>> -                                vbasedev->iommu_dirty_tracking;
>> +    hwpt = iommufd_cdev_make_hwpt(vbasedev, container, hwpt_id);
>> +    iommufd_cdev_set_hwpt(vbasedev, hwpt);
>> +
>>       if (container->bcontainer.dirty_pages_supported &&
>>           !vbasedev->iommu_dirty_tracking) {
>>           warn_report("IOMMU instance for device %s doesn't support dirty tracking",
> 


