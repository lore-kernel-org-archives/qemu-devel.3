Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F71C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 22:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfnUV-0003F3-Nm; Wed, 05 Feb 2025 17:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfnUJ-0002tI-4N
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 17:03:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfnUG-00073S-OO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 17:03:14 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfiMq009607;
 Wed, 5 Feb 2025 22:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=TN9xH3AREDG8QsEG6E8KWh3Jsy0Q7UDQZ/hEh5dx1Nw=; b=
 Bj0GGF0+fpbRdH53ctbAHxaNPaFwnIvLWQCBTqydindXcMaWUdwZ7OE3qaK+87SY
 DdhrnaRBorklnladR0ppCp3ddLc/czK25iMpsJ1ZUbbXUMDjebioJVbGHEzjqfLQ
 vavZkxi2H7kguWz7NyXiHj8dCV3w+NCNopluZM2AKX6LciVkKHIx9fHbFqBxTzW1
 U+bX4DP5k4pnLhPD+iJcdD2LdrvS49XPrG9JDIZTvsGoXd7XU6ZV5ICU+2uTylK7
 SfR26vAyey4LML2PLjojKgk9pXffzhJHa8DiUKeNOhB/+R5NT48OkhrzwNxZmAxs
 ZR+Rsy9dqELaW4cTdQ8pDA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4uckb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 22:03:06 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 515LiPL4027798; Wed, 5 Feb 2025 22:03:06 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8dp95v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 22:03:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+fC7Bm+YlhLPCijlfCS/YOMb/XNGYDrFrhtVLw+oLw52SImG18Qp90q/gz+WZr+z1yECeO56ZLMIEXyGgfyXZb0plfycIL6MI6M2e6VVkVCt1wpfEeBgqwegY6/9guV8/LMOycYumLZuiMQlK/XY0/JC+L6z2uLfU84bMdwa7k3M5KMBRrf3CjDnLoUEwFX03dqthieWiCWIQDbr9kb5JReaEWodJLMkKua6HB1C9y5T+2z8NEotkLKwY/m1h5KhWTmCS76vMfG27Gfb+eSDgtCkewqtMxpfHh5y9Uqy/jj6EyMKbuEcqBp68mw4P4M8O0SQSNFn5RBbvgpyj2m9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN9xH3AREDG8QsEG6E8KWh3Jsy0Q7UDQZ/hEh5dx1Nw=;
 b=Ej85tKaXk/nzFnZA8nsjecL1n/2PhJFZLP5P/ZrA9bHNIIha9ROj/QXQaw+xssO9ANmAFg4KEZ3b/jehzCnB4nBH5SxBIoRgatLglXUpo6E6dg1qQUwZ1k30PwR3YVNjtXOpPYR61DUg6zpr+v2T8KjgVQu9fR0XkXPv7XqDG/UW7CumUYnkpbkVH/adV8Bhc2oWBV1tXMjQQ/2bjoZNOiQXPAyJtrNRcxL309wReMP/EOIvqAaIjKy1/QJdNTHjLXSqJev8lEA+OKFRP92qc70OX+d9dgKirg4F2iCfEmRWE1gMCV4d7zNreRwnkWZygniAff59MvItbavTNer3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN9xH3AREDG8QsEG6E8KWh3Jsy0Q7UDQZ/hEh5dx1Nw=;
 b=VYIMzNzLaZa0ccAOkRdX51UfYn1Q7YPm03TaIE+Xlwan6EasI2pIU37lpfTbMcayNRAQjVSyzAEiHRwWKIKYs9AGNJCw+5TR0I2QubHp1jEpm3uCZ9AwiYwUssb6+0LhBbg6QTBOEaN6Daz8MhaxiC2Jl8Ra6spziDA1T+ZymNo=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 22:03:04 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 22:03:04 +0000
Message-ID: <61f5b569-81f5-4723-b219-6082c2784955@oracle.com>
Date: Wed, 5 Feb 2025 17:03:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 23/26] vfio/iommufd: register container for cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-24-git-send-email-steven.sistare@oracle.com>
 <8fdf7ccf-455d-4bbf-9630-5b46a7fabc16@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <8fdf7ccf-455d-4bbf-9630-5b46a7fabc16@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:335::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d42ebe0-20b4-429c-b647-08dd4630dd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blJWcEtRMXg2VmZhQ2pEbHlTRU9WMFZCM2NmQ3VZMkUwd21PZm82RFBoOTYw?=
 =?utf-8?B?K1AwK0JzUDRCSWp0TlVDaDR3a2xoSHFhR1lmT2tUNTVDTnRYM3FFTTRqQVNZ?=
 =?utf-8?B?YmRlUnR5Vm9WRDQ1d3NkRDh0U1JlWDhKdVdiTjYvaUNqaFlUQjJlTmJhalU4?=
 =?utf-8?B?dCtHYlhpOEd6Sll0K21meXpWV0Q3TjVGLzhpQmljZ1lRWWZ5L3o2eDdJWDY4?=
 =?utf-8?B?dTdHQ21idDZ5d0VLSGRYak9JVEV3MC8yNW5tTjdUVXFKZUY3ZDUwVC9zUlow?=
 =?utf-8?B?V3dYK1cwL204V2psNnRFRjY0ODRqamN3enF6NmFXVmg2U1R5V3dESmFJckNs?=
 =?utf-8?B?L0FXYzI2UXhqMVprNGpzbHBlcE5CekNlYkJPMkpiN3dxZHhUakxYTXdmaWZU?=
 =?utf-8?B?K1NuRHZTVlZ2dkxSTmdOYjIzZlVVajFXMGNmOHdTTkh2aTI0WFVuWlpSaTFL?=
 =?utf-8?B?OElUVVg0NG44elp1TFg2M2hkbDJmaEJyOSsxdStQZ1FmZVJKdExkdnRjRm1a?=
 =?utf-8?B?OGdqTjZFSHk2MjRoeEJYbENLMmVYbjB5Rkh6RFlROStHaWNxaU5DY1pFQVd6?=
 =?utf-8?B?elpQd3ZGcWd5Q2JYZmFFQW9xUmFlZU1LZWlWRmgzblZBclNuUVBYZ3BKV0FC?=
 =?utf-8?B?U0ZKRVM5VE5MbDVESHM0WkJ5S1k2Zldua3gyL1NOOFRENWxUcytLdWNEd1VI?=
 =?utf-8?B?bGdWYnRkN0UwdUE1dk9JWFZsc21OSm1nei9lYjRwMTBGdmlNb1VYTk9CZHZm?=
 =?utf-8?B?Z0tEcEF3dFYvQ3g2T2pTMTdmUkFYOVA3T2psZVk4cHBWKzRNVXdGL0RBdFdt?=
 =?utf-8?B?dkJWYURveXZJOUZRR0RRUFhkRVMzTEpzakt3MUM5SFd0M3U4c1J4OE40TXNk?=
 =?utf-8?B?Z0dHaFRnRy85a0xrZ1l1R2gxQ3lmeU1hZ1I2SXN3cG1rVjZuRnVRc2hJalNU?=
 =?utf-8?B?KzdRaXJXdVB1MnhKSjZSMGFnRUxkdUFHR0lXaUhoQUlTMnRIYjRGREZtcDRr?=
 =?utf-8?B?OHFPU0o4K1FGdi82bXJJdnJlbWZGL29iWUVSdWxYYmNkNUJGU3hmN1JzSVhO?=
 =?utf-8?B?NjNZVDczeWtXUVc1Zk1uQ1NZMG9nSXNTczVBVWFOODFacUJxUFFaNklQWVdo?=
 =?utf-8?B?cE5MM1dUSStpM0FXWGxpU1ZaWXF3Mkg0REw5TXpzQ3JTQlJZcW8vM1I5cmtV?=
 =?utf-8?B?Y2tVN2drYnhLdTM3MnkvZC9HVWNTck1VbGd4REFYeUJZRXdpOXBPbmtrL0Jm?=
 =?utf-8?B?bEVVRnlEUDBZLzhqM0ppMWFmOWMxcTlvOXlHVVZrWnpGaTIwVExwTUVRakg2?=
 =?utf-8?B?Mi9TRGZscUhyWmFjdHFGaGtNc0dUV3YrcEVWVGUzUlp5MTJBM1A1bEkyN2VE?=
 =?utf-8?B?K3dCNVlwZXp1K2c3YTlQcWdFNnVVL3haVVA3TWk2SUZ2Nk04QXAwY2Voa0JX?=
 =?utf-8?B?TG13WEVmN3p6bW0xYmlwZk1ON01VT3Q5ZzlMdDZJV2I5YU0vaExkQkcxWWln?=
 =?utf-8?B?TjBQMUtxbXhHaExYRDcxNjBNTktNMWZwcXJheTVrMzgzN0V6cUFpTEROSk15?=
 =?utf-8?B?Q2ZyTUdhclZhY3dMcGFNSVM4UVRsUUdhSk03b1I0V2dGcFU5RlJxd3BiSTd3?=
 =?utf-8?B?Tnk5bkpoQ2Q0UVVDSCtvMWNUQ1NSQnd3dHhjMy9MVEpYRjZzTjg0UEdBMWN3?=
 =?utf-8?B?MWs3ajdzZjY5SmRBSnd2eG1tZkJ4MXp0bDNzT2xldk1PUW1PNzIxYVZ5ZlBN?=
 =?utf-8?B?WUJhQUh2T2RnSEhFenF1akFQTWNsRlV5RktvNXlKTm9yVC9Md2h5b3BhODM3?=
 =?utf-8?B?bzdsdk1Cc1hBdmh6U00yd2J4TVRvTHJBUkdkaW1CTTd0Nk1oU2JBVGZBcEZz?=
 =?utf-8?Q?ME77V7YhOvOzh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YitaM1c5SFVKM0tQOUR6d25pWVlGZXFCenZkWDhqSnpWaGY5TGl3T2FUUVlW?=
 =?utf-8?B?UGdnTDVnNFM4VE5oN0xVWCt5SVdFNEw5UXVNQ2Ftc3g3MHdScWVOTEZwNUc4?=
 =?utf-8?B?TFQxYlE5QmxRNitGVmRZS1J6aDlCODVmazQ0OGg3eXdjWWJDUWsrSzF6VndM?=
 =?utf-8?B?UFZmL3Z5RWNudEtsN0ZjcnZGci9pUndFNnBDSVcyS2Rhc0pZbSs0NXRWWHdy?=
 =?utf-8?B?b2JLc1cwZGk4OXhsc0lUaitDVDQxK085SmhVdk43VVJwTkhBTW9GM003S25u?=
 =?utf-8?B?d2xtcnBHOStWYnI5d3JFT3JhOGw1Ry9tdHNJUERqQ1Zuc09JRUM5Y1dSc3Ni?=
 =?utf-8?B?cW5iUkNxc0FUVGg0Q0dOZHZIOW5KVjlIaTZzcjR1b0NOOWFOdGRocmd3QmZT?=
 =?utf-8?B?cUc5b3BDOG0xZm1yRFo2aVRwMTVPSGh4NWRGWURYSmRjSjZIcVEvOUNERXQ0?=
 =?utf-8?B?Q0hVNDY0U3BhcDFvR0VtbXVEY2FkN0w1MkpyV0luT3l4ZTYxUmZERGdGTUMr?=
 =?utf-8?B?cFJRME9BbnF5Rms3aGo3OHdaNTIvOCtsWW41dmF6TjVxOW5hR1R2WnBJQXZ5?=
 =?utf-8?B?cjM1STFvbDBTdTNrZjExNDlEd0lHQlBvNXhIWmZpRDBZWjRBNTZMVlJKK3ZI?=
 =?utf-8?B?aUxIQ3FNb3RpVDVYQTNLSUhGQWJFQndoMzFZTjNMZ2kybDBISnl0dS95VGU3?=
 =?utf-8?B?cGZvUkt0UlRTS3VQekZKeVF5UzMxK1UzNFBESklUd0VSdzY2MjBHNERZZ20v?=
 =?utf-8?B?K2x5QTJteXpBWlJQL0pJVGdzOUJxMENHSS91Mmp4NVBRcmZ5T0NPM2VDSDFa?=
 =?utf-8?B?TDh1ZjN6dFlpaE41aVJKOHZaTGhTNDA2NG5KSmNZT2QrdHg3VTkrSDkwWjRh?=
 =?utf-8?B?SjdQUUlEOFJqaWRyTmM2elJkcEZFQUJvV09WbU5uS2dROGJhQlJMaE92VTdO?=
 =?utf-8?B?a1BjU2w3ZVJ3Y3R6elowWXNLUm16UmxZNWp4ZjY5K3E4OHZQejhIUWp0NjBS?=
 =?utf-8?B?LzZtTjJ3cUtzZUtzNk40SlVOdVdiNW5rM2xka2prVmlDcDMzL1Rhc0g0ajdZ?=
 =?utf-8?B?Rk5rRytkbGptVjRISXNGaE8zQmVqd001WDcwamlpSGN2anliTWZpazNUcmpB?=
 =?utf-8?B?Y3J5Nm15T0pCSVJTcmMrZnNxUW1YRlZuSno4WlhyRC82QjAxd0xBNzlYUDVO?=
 =?utf-8?B?RjJwWkp1eGZZYzhhbWM4MUxxYmNnNHJFZVd1NWNtRzM0clJ2OWJiYnNiaERi?=
 =?utf-8?B?RWYxaG5TSGlWOFdudGYvay9WSUVXMVVYR2YvY3lZWEo5RkFNM0NBTk1yZ1RE?=
 =?utf-8?B?eGpha2hmZ3VxNmdnZGtENlFLL3YySmdSWU9KbDRmUnpLRHMrYjl1ajlSYkVV?=
 =?utf-8?B?amhyZllCK1hQL21sRy9CeDNCZG9DQ3diblczbDd5Z2pmZnpBNFlTZzhwRWE2?=
 =?utf-8?B?ejVEWlY0VFNDRXRuaC9GRWQzdlpoVzV6c2JUNmFoN3BpNVRJK0NxSFJQTGJG?=
 =?utf-8?B?ZUpKZmh0R0JhZ0J6VDdZRU41NklxWUN5cnJ6VjMxRGcvaHB1N1lrUWdoaXJT?=
 =?utf-8?B?K1dFRXdVOTRIYVRKSk1SN1FBU1MvSnBDV0ZwT3BBS3VkenNwdWdJTzRaaDBz?=
 =?utf-8?B?OGdCbGxjSlNvUFAvVEg4VSt4Y3lPZHYrUHVOaDdMUk5UenBoYlRQMXpSRmlJ?=
 =?utf-8?B?UzJyVGZNSGtuV0hUQWxndVdGc1kyTGsxMk5vSGhkRDRqUFBIQmNrMEFBUUYr?=
 =?utf-8?B?S245dWh6U2FsWFRtaGg4SEgvSit6WHVxNFRQMmY1OWtDdzZ0OEtCdWdGVmlK?=
 =?utf-8?B?TmJ1Y1dSRExhcGRtMklHQ0JrVXRsSHdPZmRNT1lXMHU4WTVPajJjcGw4blRa?=
 =?utf-8?B?R0lFY0JnQjlxVDdvM3Fway9OTVdOaHBFakxwc2NkenFwYnNYeTVCYWg0SVlW?=
 =?utf-8?B?amlaYnMreXpFTGpzWGYrbWNaZXRBT3JtRkxERUJQelBtTVFYa3ZiQ1lZYXM5?=
 =?utf-8?B?aU1JNjhPNmxKYmsxbEJSRC9ZYTJsSWEyVEE3M3E2dWJpRkliK0orU2dCVi91?=
 =?utf-8?B?Nlp0aG8wVnNUNDRBZzEybEMyUGVueGczeGprbGV1dEpEbG1kN0NEZzBZQ1Bt?=
 =?utf-8?B?dEtDcWs4Sy8vYmNkRUNaSWtJSXpPSGpKdkRvZWR6bHhIc3JzOWNsVU5xK2tr?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N6brjCEDpNTwjMVOQ4OVA/sd3gZwaCnjP/DVynCMqQF+4ECIOlrynXEwhnqHaTuN/aKwB4Tgjf5akB+lqROXX6gFyzavZWIrjC38F2U6ru7wQCWaOx9xZ1cWDlO6h7fi2MZ5SrTmdxP22OroRFsxUuf+5cP7h0e2SntndZ009jGbGgqK80dAGAnC5KaS/HGHpfuv2kcKs+14yN4MVp7k3xd0P6E4UToIJIgUIgGYdzMqFoTCFOrf/I+NyD2KtckrUsP7ziVaP1oj9nf3qa6llVfR95eK8ti7TNQIIX72Hk7QCl9aGPeW3qJ3l9YnDE/CDSfLPihYeQmNvFHknbvbu6Zg63jhAroheqhAjSt1AivFNo03iwekEJmoHnhKK+XXxfRTIMwkBWdSmExJpXNjrpyLvD/hkoWa8SU/d9vQCBpebeN3Ys+r8tBMJq0t5HzNbOnYoVps7hwcXY+W7xYN1n1XDWeFbH1j0cFmiBJyV6r7ldPrTsIm65Z/GSXyFeXWIHfW1AEJ5fKDWJM1Oc0Um90T5BBDMrHXCv8Uvzx4ydJ52OETOGrpVWNsV8Nv+GivyDswi0YTTerusDLmxTpR+IQCpM5iNXGpNEVfNtj+YEU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d42ebe0-20b4-429c-b647-08dd4630dd1f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 22:03:03.9999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfeZl1XUARWXxCdYHlFMKNK8xOqnkhbHiGdQ72ujoCV+f9rx9XWJ4AjOdWhXkZmcKh9vyG02QepzFp3xf6JlSu8G+W6WhfXpIbLHAyciL9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050168
X-Proofpoint-GUID: osHWyimoLDmh6ppbMpvfyA3Pyllfnnbw
X-Proofpoint-ORIG-GUID: osHWyimoLDmh6ppbMpvfyA3Pyllfnnbw
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

On 2/5/2025 12:45 PM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> Register a vfio iommufd container for CPR.  Add a blocker if the kernel does
>> not support IOMMU_IOAS_CHANGE_PROCESS.
>>
>> This is mostly boiler plate.  The fields to to saved and restored are added
>> in subsequent patches.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/cpr-iommufd.c         | 96 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/iommufd.c             | 12 +++---
>>   hw/vfio/meson.build           |  1 +
>>   include/hw/vfio/vfio-common.h |  6 +++
>>   4 files changed, 110 insertions(+), 5 deletions(-)
>>   create mode 100644 hw/vfio/cpr-iommufd.c
>>
>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>> new file mode 100644
>> index 0000000..4eb358a
>> --- /dev/null
>> +++ b/hw/vfio/cpr-iommufd.c
>> @@ -0,0 +1,96 @@
>> +/*
>> + * Copyright (c) 2024-2025 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/vfio/vfio-common.h"
>> +#include "migration/blocker.h"
>> +#include "migration/cpr.h"
>> +#include "migration/migration.h"
>> +#include "migration/vmstate.h"
>> +#include "system/iommufd.h"
>> +
>> +static bool vfio_cpr_supported(VFIOIOMMUFDContainer *container, Error **errp)
>> +{
>> +    if (!iommufd_change_process_capable(container->be)) {
>> +        error_setg(errp,
>> +                   "VFIO container does not support IOMMU_IOAS_CHANGE_PROCESS");
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +static const VMStateDescription vfio_container_vmstate = {
>> +    .name = "vfio-iommufd-container",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .needed = cpr_needed_for_reuse,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static const VMStateDescription iommufd_cpr_vmstate = {
>> +    .name = "iommufd",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .needed = cpr_needed_for_reuse,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
>> +                                         Error **errp)
>> +{
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +    Error **cpr_blocker = &container->cpr_blocker;
>> +
>> +    if (!vfio_cpr_register_container(bcontainer, errp)) {
>> +        return false;
>> +    }
>> +
>> +    if (!vfio_cpr_supported(container, cpr_blocker)) {
>> +        return migrate_add_blocker_modes(cpr_blocker, errp,
>> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>> +    }
>> +
>> +    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>> +    vmstate_register(NULL, -1, &iommufd_cpr_vmstate, container->be);
>> +
>> +    return true;
>> +}
>> +
>> +void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
>> +{
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +
>> +    vmstate_unregister(NULL, &iommufd_cpr_vmstate, container->be);
>> +    vmstate_unregister(NULL, &vfio_container_vmstate, container);
>> +    migrate_del_blocker(&container->cpr_blocker);
>> +    vfio_cpr_unregister_container(bcontainer);
>> +}
>> +
>> +static const VMStateDescription vfio_device_vmstate = {
>> +    .name = "vfio-iommufd-device",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .needed = cpr_needed_for_reuse,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
>> +{
>> +    vmstate_register(NULL, -1, &vfio_device_vmstate, vbasedev);
>> +}
>> +
>> +void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
>> +{
>> +    vmstate_unregister(NULL, &vfio_device_vmstate, vbasedev);
>> +}
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 8308715..ae78e00 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -592,6 +592,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>       bcontainer->initialized = true;
>> +    if (!vfio_iommufd_cpr_register_container(container, errp)) {
>> +        goto err_listener_register;
>> +    }
>> +
> 
> why this change ?

vfio_iommufd_cpr_register_container() registers empty vmstate handlers in this
patch, but additional fields are added to the vmstate in subsequent patches.

- Steve

>>   found_container:
>>       ret = ioctl(devfd, VFIO_DEVICE_GET_INFO, &dev_info);
>>       if (ret) {
>> @@ -599,10 +603,6 @@ found_container:
>>           goto err_listener_register;
>>       }
>> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
>> -        goto err_listener_register;
>> -    }
>> -
>>       /*
>>        * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
>>        * for discarding incompatibility check as well?
>> @@ -619,6 +619,7 @@ found_container:
>>       vbasedev->bcontainer = bcontainer;
>>       QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
>>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>> +    vfio_iommufd_cpr_register_device(vbasedev);
>>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
>>                                      vbasedev->num_regions, vbasedev->flags);
>> @@ -653,12 +654,13 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>>           iommufd_cdev_ram_block_discard_disable(false);
>>       }
>> -    vfio_cpr_unregister_container(bcontainer);
>> +    vfio_iommufd_cpr_unregister_container(container);
>>       iommufd_cdev_detach_container(vbasedev, container);
>>       iommufd_cdev_container_destroy(container);
>>       vfio_put_address_space(space);
>>       migrate_del_blocker(&vbasedev->cpr_id_blocker);
>> +    vfio_iommufd_cpr_unregister_device(vbasedev);
>>       iommufd_cdev_unbind_and_disconnect(vbasedev);
>>       close(vbasedev->fd);
>>   }
>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>> index 5487815..998adb5 100644
>> --- a/hw/vfio/meson.build
>> +++ b/hw/vfio/meson.build
>> @@ -13,6 +13,7 @@ vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
>>   vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>>     'cpr.c',
>>     'cpr-legacy.c',
>> +  'cpr-iommufd.c',
>>     'display.c',
>>     'pci-quirks.c',
>>     'pci.c',
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 37e7c26..add44d4 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -113,6 +113,7 @@ typedef struct VFIOIOASHwpt {
>>   typedef struct VFIOIOMMUFDContainer {
>>       VFIOContainerBase bcontainer;
>>       IOMMUFDBackend *be;
>> +    Error *cpr_blocker;
>>       uint32_t ioas_id;
>>       QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>   } VFIOIOMMUFDContainer;
>> @@ -271,6 +272,11 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp);
>>   void vfio_legacy_cpr_unregister_container(VFIOContainer *container);
>>   bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
>>                                         uint32_t ioas_id, Error **errp);
>> +bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
>> +                                         Error **errp);
>> +void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container);
>> +void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev);
>> +void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev);
>>   extern const MemoryRegionOps vfio_region_ops;
>>   typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
> 


