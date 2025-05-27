Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EC4C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 23:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK46X-0007t4-Bl; Tue, 27 May 2025 19:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uK46V-0007sW-CO; Tue, 27 May 2025 19:53:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uK46S-0006HV-SV; Tue, 27 May 2025 19:53:07 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RLN1gv026960;
 Tue, 27 May 2025 23:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=vX7Xfij91b0TEbWLRXrFwmZ/C6YCN63NDr/JtV9vHhE=; b=
 XR9I5zBcJM4YDU3ta+lWlmPtsQV275EsFGHyVOrg5pN72SopmwWyllvogt0yqoq/
 us3WTMH6+n5zVAF9eJe0kXzt/+Ho4+B803Zg1T9LdcJCj2jw4QZfbEdud+IbN1Jb
 Z+XBZdGla6zyPo6VR7zPvFRg04ZdgOgPZ0dyh0SIcD2AoZgTBwVM9UdlUjGzFIM/
 VoDgKAUbO2qVy1IW0u1xgVsaVM8P0cKEAAJ1bZB2VKDvvi5szzGgEFSq5KOa/CJs
 OgkG4A3WvgVQ7xmOD3wN8wxxSxgYKl02QyY1XGxFHtPMDfA9wOaEfZSaMDUT6PmZ
 JgxlchEWoeUnvhpl3lsNcQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46wjbcgr90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 23:52:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54RMpRtP035677; Tue, 27 May 2025 23:52:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jaqr9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 23:52:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InbsQi6mFoMsHF2Qrj9GQMg0bfl8JG0PgevEAlI9UnWCB3vFuazYpj6igP7MkQ/cYPclw8o9bApzfmMjMPqv2cvctvtIfE1EZVlVPlzgscqBtLBP96UoqfJiDg5FujuDVyt5xBFIb9p1bpbu7LHTkkUDQuP74FWUo78kvdiZDCaF6/Xs9tUlcCzOYbofYK/tS1ronuuT1I9IxGL+O4M1GekW2pR+9Cgl8V4efYwk3vzH2t4RyG6V1flGdtIiCxSNWxe+e7IeUyMU4qlo2AaOBQ8drmRnYZg58maAxoOwUMJEEMl2U3AoIFW8f4j1s12m5lmn+80sjXFsbf727EVbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX7Xfij91b0TEbWLRXrFwmZ/C6YCN63NDr/JtV9vHhE=;
 b=Ogm2BHXhPkp+pg7hfuF5oIJ7p7qTMckDzftffe2QCIjw7pbKKlpEYd3Xi7MGHhKggMDfaLzp+kK5zSP0OZXRLDw01Cw/F3MVWdCGvnK6FjU5at0iJ24k7/l445ADNG+XlA4pJCteXe1DioC5KjpK/pKgSs73kDo0X9jW19OSoBpTrKHLRnpHhFCdcCr0uK/qzv+w/yG26dggDdEZtaS/6C83Qj1eQ2WboZXJhPLuwfJlfq5D003bI6QPbcKiTghNd3a0BSsi908mi+6V/bdI4rRPgRI6tgaTF7O1eNceEHDjKoopvPIafQ7+koe0FA61tAL9GalX0H2oh4DZRHB5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX7Xfij91b0TEbWLRXrFwmZ/C6YCN63NDr/JtV9vHhE=;
 b=Gr/l2cyHu0bm+Pym2ghvjrEZ4ujKwZBHmF38txV0qbd/Gpli9lCDZl0zDMqWj55DYONz6s/fTcLKuUSZkkafiEGM+54u5pRVYJzbxrNz5j6EvwCaNiCsRgJA0ghL1AK1pWI+OGFNsbLiEOUrIQL+62y0ZMrfj9kDuYgtHYaEYhk=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SJ0PR10MB5767.namprd10.prod.outlook.com (2603:10b6:a03:3ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 27 May
 2025 23:52:41 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 23:52:40 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Marc Zyngier <maz@kernel.org>
CC: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "gkulkarni@amperecomputing.com"
 <gkulkarni@amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Topic: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Index: AQHbztA2f3Tkb/6RVECgRowZ7mB7d7PmF3GAgABDNICAAAY4gIAAFtEAgAAGLACAACQFgIAAEAWAgAB1TAA=
Date: Tue, 27 May 2025 23:52:40 +0000
Message-ID: <F906C99A-DEAA-4211-ABB1-BE12374E4AC6@oracle.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <86msayec3a.wl-maz@kernel.org>
 <63FE2592-DF4D-4CCF-BC76-D8656C9EFA0A@oracle.com>
 <86jz62dzxa.wl-maz@kernel.org>
 <A5135210-4984-4532-B0AF-9CDC8255CBD0@oracle.com>
 <86iklmdv4d.wl-maz@kernel.org>
 <A3872288-67B7-4C99-84F0-19812758FCF0@oracle.com>
 <86frgqdmhy.wl-maz@kernel.org>
In-Reply-To: <86frgqdmhy.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|SJ0PR10MB5767:EE_
x-ms-office365-filtering-correlation-id: 47272652-d3a5-4567-fa7b-08dd9d79912b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eWNlL2hlL0E2cWRpR1NmOEVDODdhOW5kWFFJbWVCcCtnR0VETWJidW95VEoy?=
 =?utf-8?B?RlBEbmpNbXZEa1N0dVJ3ZUF1SlJMR1pSakN1M1VoUkw3eVNGZm1ncXM1aTNW?=
 =?utf-8?B?R1NPc01yOXNXYWp2WDNLNzJMMndIYm10YmhVUUlqNXQ5NWF0MXZoQ1Q4ZFJH?=
 =?utf-8?B?VWl5bG5KSEVNUVlvbFMzZk5yN2p5cnVCMDhEV2l0YTNEcytnY1VybXU2c2tv?=
 =?utf-8?B?cHRZMUNpWVlxMzBVNFRlb3JVYVlEZmFLZHlNcU1aN2JURVpXZllUaGF6alJ2?=
 =?utf-8?B?dWxVZWVMdk51QVMxYVYrellYWEJsVGJkeXJQK2FGMWtwem5VVXU2UmJyQVJI?=
 =?utf-8?B?S0xsSWQ1Z1VOQ2FLTjhsWkdxY1FWbTUyWEtKL1doM1dEbjFHeXhpTFlJMmhp?=
 =?utf-8?B?R2VvbGU3KzNSbGJEWFZteVZlRmZFNGdKVVE0bzYyVEpFNzY5dno5K1FtT3Rw?=
 =?utf-8?B?cm9EaWpHZ0ttbklPR0Ywb0pZN1BVbHVWUHNzTUVsZnRLQkRtS3NYRVV4TExS?=
 =?utf-8?B?NjR3N2pOLzJ0VEhkdWRqWUhkRndqZFUvUGlJdnkzcnJmYTU2S1MwazN2bjBw?=
 =?utf-8?B?K0ZPeXRmYkd0Z09XNk9UYnA0ek1raklUa0RVVC8wdlg3ZkFPVStCU2lwRUlI?=
 =?utf-8?B?Q0hVTERydDd6TWIzQlUzbUdBMi9ianR4SnBOeGVpQlJQV0NWOUVoWHdiYXFD?=
 =?utf-8?B?d3d3dmQyM0p3QUZUb0tJblo0TGFCRVVFVlZUSW80dytJcXMzemFKNXJGeW85?=
 =?utf-8?B?ZTlIUGdvYXFtQmNTOXFmY01vYktBVXZuM1dkZ09IVVV0WTNyU1p4MkJlcWZa?=
 =?utf-8?B?NTJtT1ZsVGc2c0RqM29PZkY0TFZHYW1WNi9HWElIZnBIbXJzWm9BWUtad2dr?=
 =?utf-8?B?c2dVSjZ4cWFnY1dGbWlpRi9JUy9PenJITGFSVmdSemo4djZZRDlkYXJmbnJ0?=
 =?utf-8?B?c1MyQ1J0dlJFVExQdU9pY3B1L3FXa2Zac3Fac3lUYmpiRFpNMGZ3c1p2V3RQ?=
 =?utf-8?B?T0V4a0R6Q2pwZEdxQ3p4QXhScFlmTVVlWUt3R01iRzZSWmxReFZNRFVhaWND?=
 =?utf-8?B?L0N1QitXMEM3L0NBUVdTYTk2ZkEvNjJlNTBaNHJ6bFVnWlBCb0traGV1dkg0?=
 =?utf-8?B?Y1diYWNaWFU3Rm82VEV4QTY2UWZCTWtKTWdMN2FndEgzR1pibHRFQ1FuckIw?=
 =?utf-8?B?bUlPdFJFU0ZFRTVaRUYxQmJvUEpSSkh3dThNaSs3aU85QXdvdndDR1hJVkxw?=
 =?utf-8?B?dGNTL1dNOGZoNmNyc29adG5rY1ViRjRMRUdnM2RZZU1RcXRkK3prY2ZVelpl?=
 =?utf-8?B?c2pTelhFa2d6YldFQ1JTczJacERIZ1A3YkhrNVpYTzJIamhRb1haeW95TWl6?=
 =?utf-8?B?TEtwSjNtUGNHWnNMcDNENjBBUGZad1dpekRJL1RiU3cyREttQWx1WnlqRGtQ?=
 =?utf-8?B?OGRyNXZWRkIxd1FiTHlxVTNXOXIra2dIVXJFY25zU09RNWFMWlJlbjVvNzZJ?=
 =?utf-8?B?OVN6VWQ0Z0drYk4rWWJiN2tBMlJReTlVdTE3S3U0a1lHNkhXUmM4dVJySmJM?=
 =?utf-8?B?QW55UUdxUE5CZno3T2RmVVlkU1Zmd1VpVmxDSXBDdVRldVZmMDYxTjhHTDFz?=
 =?utf-8?B?QmlNNjdHcWJ0aFRQdFpvRHlWdW5jdTBDYUMyVjRJU3lKTXQvbVFWYlFMb285?=
 =?utf-8?B?U2VLZUsrcTZTNEJMODF2S3gwWDhLRHZkWWp3NkxLUkoxSGkzQUhOZjlUUmNr?=
 =?utf-8?B?MjVnckU5NmE5dWt3bUd5dTI0Q0RsQm1ha0hvK1hMYTFDNDQ3eUVZS01ZVklh?=
 =?utf-8?B?ZTAxK0V1K2JSSzR4OG5wY2Y4NFhkUVFnaFFnNFFtUjlEZnI3T2hUbFVRRXFG?=
 =?utf-8?B?Rk1SWkRlY2NsR2FZUHJYQ1J3cHJmSmw3VW5JV04rYzJzbktFR1o5NXFIR3di?=
 =?utf-8?Q?IX/iHR21bZI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2UwVTJHNkE4TDJRakNQV1FqUC9xbGVzK2t3blVmSitSZzJveGJTeStPdWNQ?=
 =?utf-8?B?RXVQdEhnNFUwZnYzNk4wUkphL1FlMERSUXI1TzdKQWZRa1hobjg0dXAyRjJ6?=
 =?utf-8?B?aHJxc293ZUhOVERRVmRmQTNqeDJvdnFmOHMzazh3ODlVdkhWMzNvcnNFNGdO?=
 =?utf-8?B?MHFvZDdlL0ZrWmNjY1c1OHJZVS9iN0xPREw0WDMyVkh0SzJaN2RiR1hPaXdI?=
 =?utf-8?B?QVBxNkZOMmlTbjBGVlIvT2daSXlPQ0UzUHVxVmNBZ0h6WXZNOCtUcVUwaUlG?=
 =?utf-8?B?VHdneFE1SkU3MVh0ellSSkpxVWJpUTY1MVIwbWNHa0dCTmVmSDZTeHVWenlk?=
 =?utf-8?B?cXdFeVpwQVN4NExIYUtWZ2krZlR1RzdzeXB5UGVDWVN1RWtaV254aU9Mczlo?=
 =?utf-8?B?Nnd4bW1RL0E5eWJDNkM4TGt0dHc4R2c0L0FTbFY5L0FZZkEzanIxS2ZsNzll?=
 =?utf-8?B?U2dGQWRlRmgvR2dYNzY3L3J3V3lDNFliamw3TW1lMlVzNXFPNG1WUkNvYlFB?=
 =?utf-8?B?RExpZERFZEJ2amRVbjBIYUlCM2xXWEJhYmpyN0xJOGhJZER0L2svb1dLSkZI?=
 =?utf-8?B?SmQ1TWpZL3dyN2N0dDVHTDJoRWl6bWJjNVg3K0hkRWRRSGFPNjYrR3VOcysx?=
 =?utf-8?B?NFlQOGxnY2xnUmFpNFlUN25TVXhpcUpzdk8xTk5XV1FtUUdDaG9maVZaclVj?=
 =?utf-8?B?WmduRTBVdkp0dXhaeUM3b2ZpZFZSSE9ZNndFQWdUZ0dFVVZHSkwzbHgwL2tF?=
 =?utf-8?B?MjJ0WmFPV0dUaGI5R1I2WWRkYTZZMGpNS0QrWGhDNVQ4Njh0eDNsNFZYZW15?=
 =?utf-8?B?VkxEUHhFM21vM0FzOU9ud1JzL29FVldES3dqUjRyUzZRcTZhMzNVZzl0b08z?=
 =?utf-8?B?bUk4ZThKbzkrdUxSM1ZZTlRqb1BHbU9tL0x6MjJjYjcvSkZuNkZWQndISWlS?=
 =?utf-8?B?YXErSnZBdlhJQU9WNTB4SzFpMVdPVXZKQW5FNWhVQjE5Q0JEblBrRzQyRDZM?=
 =?utf-8?B?VjF3ZGtvV1l0Tnd0enNWNVE5Smo2b3hKcld2bG53aG94K3RZaFh6UE9EWS9G?=
 =?utf-8?B?Z0t2ZnVFdWxLY0dibWRYNFZNOFpiSkdIYkwzRzdrcEM5NXdYNHQ0Qm84MGh6?=
 =?utf-8?B?VzJTeVJsNFd0R2FySGdKQ2ZwYUhCbkM2N2NUUDEyNDZWL2prSzNObWhrNzJx?=
 =?utf-8?B?eG1qQWlpNzZuUEVPeFRKOHcya1ZQOFRoRGN4R3VXR1ZtZXVlK05Vd3dCSEEr?=
 =?utf-8?B?OGJITXpoQTlXenRGMkZORmxGU0dLbDR0SXV3TGhreFFBU0VsMGpRQkVnYXA1?=
 =?utf-8?B?aGZHZ3pES3hNa3pCVWNBejlWeFQ0MW1NL0xtNjFPMmdIN0IzUGs1Q1Y5NXlR?=
 =?utf-8?B?S1VpVmloNlVhS0JIclc1L0NadjZJNCtreFdvanJYaDhMK3ZHMEI2M3I1Z1hy?=
 =?utf-8?B?VE1laUFjaE5CQk1rZzFZT1NWK0xsZmRJREpSaWFoL212SllEa0kxNmZyTGdp?=
 =?utf-8?B?N1VXVnNIbzcrYjFmM2Rabm9kTndOV0lpL2lFRE9zNFNMaVNWTmFsYVljZ01E?=
 =?utf-8?B?QUc1WWhMRlNLNDVoTzlROWVvLzNYaXVRczhuS0kyM01CL1NCVmFxUUtXMzUz?=
 =?utf-8?B?WGhXWEpWZkN5aXNPSSs2OTRQZitrcnNqM1ppRm04dExTRTdrWUY1eWR6RmFr?=
 =?utf-8?B?aTJBZXpNbjJycTlaRkRtaDR2czYzREhkdEJRQThlNU1lREd2VWQxU2NNSGdv?=
 =?utf-8?B?Slpab2RaSElxdnd2UkJtcENxSXE3ZXJLSnY0UVpmeWZjdkVvT3dwWVRGQUVK?=
 =?utf-8?B?WGxiTktxczVyampYOVo5SjIzUXdZTFhRY0thdjdZMWttMG1jMWlhMzRjaHNX?=
 =?utf-8?B?b0RJRkZ0OUJCQkZnYmNBZkdmc0F5bFRhK2RJMUx2T3R4THVPa3I5V2dvdWZv?=
 =?utf-8?B?WVB1WkZFMFBoS01hWUpVek5xSmdVZ1NaME0ydUJtVVJlL3NEdGh1L0h5Qm8z?=
 =?utf-8?B?dVlvQ0swOVRudDY1WnJ1S2x1cUZPcDlVdDRrNXpOWlV2Lyt2NGNHdXV3TVg3?=
 =?utf-8?B?OWh6UTNpVTZyM1cxWVZZRVNaeXM3Zk5KSE1SNEVVMnQ2YXJ3K0drVlNEOWo1?=
 =?utf-8?B?aStrQ2NhL2FLVElDbEY4eWpNZjR1K1BscCs5VkdMRnpHTWNWcnQwVS8vcXE4?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56FB676F55C3F04DB253A545D5688176@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 04UcO8yif+Nba6z3FfDw36fitvAqIrOS2bRwcbk20F/JseafXR7I4taykuiGt0RZ19VPsK0MonGOmDwRkPB7guGFics0PQ2QKsMkfDHpQSDL/q7v9oXSiF3qYLe5foeja6x9xj/sTNMz9OgACTJPRyS4M3hJrwTXROnWgPUeosg2A9CF52nCq0XZLLczp9UHv6G4iUdeRXrUKMezRjqLK2ADqCamT9sv+c92L1unCPcuffcih6XFOghM2J0oqkd1XEPordLPnghZ8MYVAdXzx8Bdt4M8jaitQixF7SLalcM9QVqV1bwyAduzsUaCzGpc3+Os9AP+eHrgNS9+ub+DCEl21Ax2sKMxVo4XBZ1u/D83eGy8bmZMmweYGguWaM3Fl8g3Zl171Ib8UJ/B3kh5oUEfMlN9nHUDDkIKz+Z9lkMOvS4W8ZA7b85/RODbAulLx7UCVaNbBoz0y5ufSMogj2mFhGqtIZq304RtdcKl5LcXwRNdOcJKQX9a/oq46lpNgc++2J0Lh3gGMni5WXuDM/AYNk95hGWqsc+mEc7AwEQsJAlZaIogbb6unCW6sju4KJ7qaEP9LyyWVouvOgF9LQTN8hYdAnrkOn8NElgAKJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47272652-d3a5-4567-fa7b-08dd9d79912b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 23:52:40.8255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OiEoQz1O0VHiVz6HFfawWBmYR7H3uSZqhg1HEqkFvCo2+LC8nB5BPxadb7KQ5crw47htqIV5kpHQ7Thk1xyJGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505270202
X-Proofpoint-GUID: jsLt0trlsi08kUlaoBeSTC6WCkcOsTNR
X-Proofpoint-ORIG-GUID: jsLt0trlsi08kUlaoBeSTC6WCkcOsTNR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDIwMyBTYWx0ZWRfX+0/bVjnF1+xJ
 ye1YwNe4HUE2iOncNlFhjkeSSr+THvf/Ktrx67mwKDDgEd3NJ3oAnq0pq1sDQrcgju4vuGryczq
 N7y+VjD4iynpMKM8hYTevzssUdSIydF2wjj3JhqKV6G59O5UbzpyhHdw3s2payN6E+BN0GtGuaq
 Bs8le1Wo5refHr3SnUAhnyN614y7YH1JHj6HgkkkssW4I0yT67fjBFSBOHm4Lbw32u1gXobkEjk
 swJWxwWBREEIyj/1xgQiKFgClYiowoG2uF2EYwzIFGVPYTL7viITrb2uLX49ui+bF0hODofwv/u
 li12xl+D+9PEz3gSGMBiSZlRWfRIqxH1tBCxigQmCvHwskFpQvyji5x9FeekdEid7aj696+OUJW
 ioHy+/3gtrhZ1lkqjWwoWydaUJhCk/Jphdyxv2xeYafO+h/DT1D9SFs/dahYUPqbQnuTGp71
X-Authority-Analysis: v=2.4 cv=c8qrQQ9l c=1 sm=1 tr=0 ts=68365058 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=fGO4tVQLAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=1-FVdjZkdA3Auc3zz-sA:9
 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
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

DQoNCj4gT24gMjcgTWF5IDIwMjUsIGF0IDE2OjUyLCBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwu
b3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjcgTWF5IDIwMjUgMTY6NTU6MzIgKzAxMDAsDQo+
IE1pZ3VlbCBMdWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0KPj4gSGkg
TWFyYywNCj4+IA0KPj4+IE9uIDI3IE1heSAyMDI1LCBhdCAxMzo0NiwgTWFyYyBaeW5naWVyIDxt
YXpAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gVHVlLCAyNyBNYXkgMjAyNSAxNDoy
NDozMSArMDEwMCwNCj4+PiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4gd3Jv
dGU6DQo+Pj4+IA0KPj4+PiANCj4+Pj4gDQo+Pj4+PiBPbiAyNyBNYXkgMjAyNSwgYXQgMTI6MDIs
IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiBU
dWUsIDI3IE1heSAyMDI1IDEyOjQwOjM1ICswMTAwLA0KPj4+Pj4gTWlndWVsIEx1aXMgPG1pZ3Vl
bC5sdWlzQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IEhpIE1hcmMsDQo+Pj4+
Pj4gDQo+Pj4+Pj4+IE9uIDI3IE1heSAyMDI1LCBhdCAwNzozOSwgTWFyYyBaeW5naWVyIDxtYXpA
a2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+Pj4+IA0KPj4+Pj4+PiBIaSBFcmljLA0KPj4+Pj4+PiAN
Cj4+Pj4+Pj4gT24gVHVlLCAyNyBNYXkgMjAyNSAwNzoyNDozMiArMDEwMCwNCj4+Pj4+Pj4gRXJp
YyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4+Pj4+IA0KPj4+Pj4+
Pj4gTm93IHRoYXQgQVJNIG5lc3RlZCB2aXJ0IGhhcyBsYW5kZWQgaW4ga3ZtL25leHQsIGxldCdz
IHR1cm4gdGhlIHNlcmllcw0KPj4+Pj4+Pj4gaW50byBhIFBBVENIIHNlcmllcy4gVGhlIGxpbnV4
IGhlYWRlciB1cGRhdGUgd2FzIG1hZGUgYWdhaW5zdCBrdm0vbmV4dC4NCj4+Pj4+Pj4+IA0KPj4+
Pj4+Pj4gRm9yIGdhaW5pbmcgdmlydCBmdW5jdGlvbmFsaXR5IGluIEtWTSBhY2NlbGVyYXRlZCBM
MSwgVGhlIGhvc3QgbmVlZHMgdG8NCj4+Pj4+Pj4+IGJlIGJvb3RlZCB3aXRoICJrdm0tYXJtLm1v
ZGU9bmVzdGVkIiBvcHRpb24gYW5kIHFlbXUgbmVlZHMgdG8gYmUgaW52b2tlZA0KPj4+Pj4+Pj4g
d2l0aDogLW1hY2hpbmUgdmlydCx2aXJ0dWFsaXphdGlvbj1vbi4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+
IFRoYW5rcyBmb3IgcmVzcGlubmluZyB0aGlzIHNlcmllcy4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IERv
IHlvdSBoYXZlIGFueSBwbGFuIHRvIHN1cHBvcnQgdGhlIG5vbi1WSEUgdmVyc2lvbiBvZiB0aGUg
TlYgc3VwcG9ydA0KPj4+Pj4+PiAoYXMgYWR2ZXJ0aXNlZCBieSBLVk1fQ0FQX0FSTV9FTDJfRTJI
MCk/IEl0IHdvdWxkIGFsbG93IHJ1bm5pbmcgbGVzc2VyDQo+Pj4+Pj4+IGh5cGVydmlzb3JzIChz
dWNoIGFzICpjb3VnaCogWGVuICpjb3VnaCopLCB3aGljaCBjb21wbGV0ZWx5IHJlbHkgb24NCj4+
Pj4+Pj4gSENSX0VMMi5FMkggYmVpbmcgMD8NCj4+Pj4+Pj4gDQo+Pj4+Pj4gDQo+Pj4+Pj4gU29t
ZXRoaW5nIHRoYXQgcG9wcyB1cCBpcyBlYXJseV9rdm1fbW9kZV9jZmcgdHJ5aW5nIHRvIGhhbmRs
ZSBuZXN0ZWQgbW9kZQ0KPj4+Pj4+IHdoaWxlIEtWTV9BUk1fVkNQVV9IQVNfRUwyX0UySDAgaXMg
c2V0Lg0KPj4+Pj4gDQo+Pj4+PiBDYXJlIHRvIGVsYWJvcmF0ZT8NCj4+Pj4+IA0KPj4+PiANCj4+
Pj4gU2F5IGhvc3QgaXMgYm9vdGVkIGluIG5lc3RlZCBtb2RlIChrdm0tYXJtLm1vZGU9bmVzdGVk
KSBhbmQgaG9zdCdzIEtWTSBzdXBwb3J0cw0KPj4+PiBib3RoIEtWTV9DQVBfQVJNX0VMMiBhbmQg
S1ZNX0NBUF9BUk1fRTJIMC4NCj4+Pj4gDQo+Pj4+IEEgTDEgZ3Vlc3QgYm9vdHMgc2V0dGluZyBi
b3RoIEtWTV9BUk1fVkNQVV9IQVNfRUwyIGFuZA0KPj4+PiBLVk1fQVJNX1ZDUFVfSEFTX0VMMl9F
MkgwIGFuZCBndWVzdCBrZXJuZWwncyBjb21tYW5kIGxpbmUgc3RhdGUNCj4+Pj4ga3ZtLWFybS5t
b2RlPW5lc3RlZC4NCj4+Pj4gDQo+Pj4+IFRoaXMgc3BsYXRzIHRoZSBrZXJuZWwgZnJvbSBlYXJs
eV9rdm1fbW9kZV9jZmcgYWxvbmcgYSBtYWxmb3JtZWQgZWFybHkgb3B0aW9uDQo+Pj4+IG1lc3Nh
Z2UuDQo+Pj4gDQo+Pj4gQkVCS0FDLiBZb3UgYXJlIGFza2luZyBmb3IgbmVzdGVkIG9uIGEgKHZp
cnR1YWwpIG1hY2hpbmUgdGhhdCBkb2Vzbid0DQo+Pj4gc3VwcG9ydCBpdCwgYW5kIHRoZSBrZXJu
ZWwgdGVsbHMgeW91IHNvIHdpdGggYSB3YXJuaW5nLiBUcnkgdGhlIHNhbWUNCj4+PiB0aGluZyBv
biBhIHBoeXNpY2FsIG1hY2hpbmUgdGhhdCBkb2Vzbid0IGhhdmUgTlYsIGFuZCBvYnNlcnZlIHRo
ZQ0KPj4+IHJlc3VsdC4NCj4+PiANCj4+IA0KPj4gQWNrLg0KPj4gDQo+PiBJIGZpbmQgdHJ5aW5n
IHRoZW0gYSBncmVhdCB3YXkgdG8gaW1wcm92ZSByZXNpbGllbmNlLg0KPj4gSeKAmXZlIHRyaWVk
IHRoZSBzY2VuYXJpb3MgYmVsb3cgd2hpY2ggaGF2ZSBzaW1pbGFyIHJlc3VsdHMgb24gdGhlIGd1
ZXN0Og0KPj4gDQo+PiAxLg0KPj4gSG9zdDoga3ZtLWFybS5tb2RlPW5lc3RlZA0KPj4gDQo+PiBM
MSBHdWVzdDoga3ZtLWFybS5tb2RlPW52aGUgc2V0dGluZyBib3RoDQo+PiBLVk1fQVJNX1ZDUFVf
SEFTX0VMMiBhbmQgS1ZNX0FSTV9WQ1BVX0hBU19FTDJfRTJIMA0KPj4gDQo+PiBSZXN1bHQgb24g
dGhlIGd1ZXN0OiBObyBlYXJseV9rdm1fbW9kZV9jZmcgc3BsYXQsIGJvb3QgcHJvY2VlZHMsIGVu
ZHMgdXAgaW4gYSBoYXJkIGxvY2t1cCBzcGxhdC4NCj4gDQo+IFNldHRpbmcga3ZtLWFybS5tb2Rl
PW52aGUgd2hlbiBLVk1fQVJNX1ZDUFVfSEFTX0VMMl9FMkgwIGlzIHNldCBpcyBhDQo+IHRhdXRv
bG9neS4gVGhlIHZlcnkgZGVmaW5pdGlvbiBvZiBuVkhFIGlzIHRoYXQgSENSX0VMMi5FMkg9MC4N
Cj4gDQo+PiANCj4+IDIuDQo+PiBIb3N0OiBrdm0tYXJtLm1vZGU9bmVzdGVkDQo+PiANCj4+IEwx
IEd1ZXN0OiBrdm0tYXJtLm1vZGU9bmVzdGVkIHNldHRpbmcgYm90aA0KPj4gS1ZNX0FSTV9WQ1BV
X0hBU19FTDIgYW5kIEtWTV9BUk1fVkNQVV9IQVNfRUwyX0UySDANCj4+IA0KPj4gUmVzdWx0IG9u
IHRoZSBndWVzdDogU3BsYXQgYXQgZWFybHlfa3ZtX21vZGVfY2ZnLCBib290IHByb2NlZWRzLCBl
bmRzIHVwIGluIGhhcmQgbG9ja3VwIHNwbGF0Lg0KPiANCj4gSSBkb24ndCBzZWUgYW55IG9mIHRo
ZXNlIGxvY2t1cHMgd2l0aCBrdm10b29sLiBTZWUgdGhpczoNCj4gDQo+IGh0dHBzOi8vcGFzdGVi
aW4uY29tL3V5WXpzQkhjDQoNCkNvdWxkIHlvdSB0cnkgYmlnZ2VyIHZhbHVlcyBmb3IgLWMgYW5k
IGNoZWNrIHdoZXRoZXIgeW91IGNhbiByZXByb2R1Y2UgdGhlIGlzc3VlPw0KDQo+IA0KPiBmb3Ig
YW4gZXhhbXBsZSBvZiBhIGJvb3Qgd2l0aCBib3RoIGNhcGFiaWxpdGllcyBzZXQgYW5kIHRoZSBu
b25zZW5zZQ0KPiAibmVzdGVkIiBvbiB0aGUgY29tbWFuZC1saW5lICh5b3VyICMyKS4NCj4gDQo+
PiBEb2VzIHRoaXMgbWVhbnMgdGhlcmXigJlzIGEgZGVmYXVsdCBmYWxsYmFjayBtb2RlIGluIHdo
aWNoIG52IGdldHMgb24gd2hlbiANCj4+IGt2bS1hcm0ubW9kZSBmZWQgdG8gdGhlIGd1ZXN0IGtl
cm5lbCBjbWRsaW5lIGRpZmZlcnMgZnJvbSB0aGUgZXhwZWN0ZWQ/DQo+IA0KPiBJIGRvbid0IHVu
ZGVyc3RhbmQgeW91ciBxdWVzdGlvbi4gV2UgaGF2ZSB0d28gbW9kZXMgb2Ygb3BlcmF0aW9uOg0K
PiANCj4gLSBIQVNfRUwyIGVuYWJsZXMgTlYgb24gdGhlIGhvc3QsIGFuZCBhZGRpdGlvbmFsbHkg
ZW5hYmxlcyByZWN1cnNpdmUNCj4gIE5WLiBBcyBhIGNvbnNlcXVlbmNlLCBIQ1JfRUwyLkUySCBp
cyBSRVMxLiBUaGlzIGlzIGhvdyBOViB3aWxsIGJlDQo+ICBzdXBwb3J0ZWQgbG9uZyB0ZXJtLg0K
PiANCj4gLSBIQVNfRUwyX0UySDAgcmVzdHJpY3RzIHRoZSBhYm92ZSBieSBub3QgZXhwb3Npbmcg
TlYgdG8gdGhlIGd1ZXN0LA0KPiAgYW5kIGVuZm9yY2luZyBIQ1JfRUwyLkUySCB0byBiZSBSRVMw
LiBJIGV4cGVjdCB0aGlzIHRvIGdyYWR1YWxseSBiZQ0KPiAgcmVtb3ZlZCBmcm9tIGltcGxlbWVu
dGF0aW9ucywgYW5kIGV2ZW50dWFsbHkgZGlzYXBwZWFyLg0KPiANCj4gQXMgeW91IGNhbiBzZWUs
IHRoZXJlIGlzIG5vICJmYWxsYmFjayBtb2RlIi4gWW91IHBpY2sgdGhlIG1vZGUgeW91DQo+IHdh
bnQgYmFzZWQgb24gdGhlIGd1ZXN0IHlvdSB3YW50IHRvIHJ1biBhbmQgdGhlIGNhcGFiaWxpdGll
cyBvZiB0aGUNCj4gaGFyZHdhcmUuDQo+IA0KDQpJ4oCZbSBub3cgc3VzcGVjdGluZyB0aGUgbG9j
a3VwcyBtaWdodCBoYXZlIGEgZGlmZmVyZW50IHJlYXNvbiB0aGFuIGd1ZXN04oCZcyBtb2RlLg0K
DQpUaGFua3MNCk1pZ3VlbA0KDQo+IE0uDQo+IA0KPiAtLSANCj4gV2l0aG91dCBkZXZpYXRpb24g
ZnJvbSB0aGUgbm9ybSwgcHJvZ3Jlc3MgaXMgbm90IHBvc3NpYmxlLg0KDQo=

