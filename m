Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21C5C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzr46-0004hK-Lm; Fri, 28 Aug 2026 03:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wzr45-0004h9-Qm
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:31:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wzr42-0005KM-VB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:31:53 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S3D0Mg1709455; Fri, 28 Aug 2026 07:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=rI12tix1iwg2GmEcRotyqGQ9Zw1WWDdsH0Gi0xSv06I=; b=
 ci09xGnMufdMqqORzQxzFNlnUukA72TyKXKa7u3rBEGZOMWKx0q8+uCNZmxad1fw
 SCZL3Im1JKOL8MpZ93qr42KGcHx6DHZ8s8pYkOTz0/LmPhR0Hf7xyrZ5EnKSh+cz
 nQJjqpChF3//NHzG7tAQc2R+LyYmtkLm73JxHf8x9yRg86rNdvayxKCPVvcP5bqZ
 nPklr/DdQa5IeSBau3yNAwEWouYD2lwWWgOx4Im5d7A7Tc75DhqvPIPmWGAyXEj5
 04JnYtiAkbWrHS6W9yvkm4xYR90njqCQcVUOv/F0McEdNQGXP6Gv7VIOPl8cScQu
 oymLIlAj3rRfAgk0c+4ihQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g73ct1e5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 07:31:45 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67S7TvP1018742; Fri, 28 Aug 2026 07:31:44 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010036.outbound.protection.outlook.com
 [40.93.198.36])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4g84bubqq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Aug 2026 07:31:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsxxHG8OvDF3kyeGr8Cv/gz9kj4+LgkC1pxOLXp+4hkGSQ5+7xkFoTNC6iFvYEhi2anzTrmjp/x5JKSk5oh53/kZWGLDIgbWHBCOR0Ldo4FXlMzwNa3js6SfNSMBadRZ242QS2ZDn57hWAWfTRc9mPCgcIgpAjyO+Y73Mk8RN0GLoLKVDbtS5sC/xxpF7lWuWHSUJo0lxBELtu/1qPHnVj/8X7hfx7wyBfdiO2VxuaMPUiaQg7QBL06vFx2QLDzOOTSF3bpLhPgTB6EHzg3Ku6M4t/35BNTjRhkDojLJ/jhno23VJIt6i4hJYCjI9Nr+u20rq5uwouxR7RVYgU+3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rI12tix1iwg2GmEcRotyqGQ9Zw1WWDdsH0Gi0xSv06I=;
 b=HIv3CmVjaZVL/P5ZjFCP5V1lUdJLdr7poF4nzbuA2RzNKG1fX2FbeQVP38Sa9EW2e0U1uQPHJLy6XUDtNytCFbODFvJWkOU+z50H9V4eRHdQKHbfT2IX80WPXXpE/gDfhqQNRRN4sb2TPFjJNs7QlHGl4JaEETWlPn9Xu3p4ZO9Dda24dh641fWzamcXGBoD8ReLbHPb7udWvZ8nfdWogBAHmH553OqlFuPxMhOb05vV/ZAG1M1V+pgqLRFuVSOXfcoSegjc+PJPw4Aq+7WBrub78odUDx9KNfLvhoLs7E1Y7Gb4P5nR7MEG41+NVkmzVYCk5RsUwJMJV3H74ryruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI12tix1iwg2GmEcRotyqGQ9Zw1WWDdsH0Gi0xSv06I=;
 b=PGiieV6jjUss4spnyj/4I9L+zO20lgjScYj4sv/dGNC+EbDDIROMf3/552zblYGvGrkyBbhK6c6dH7TzzPDJB5YRtqdkXLCDyF+qqFiUM7B8uSUYv1QC0NFJfyJV6KtYT6KblYgIrscZeJluk+jvnuXksD88u6/P1XTz/WZr+kw=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by PH0PR10MB7079.namprd10.prod.outlook.com (2603:10b6:510:28a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Fri, 28 Aug
 2026 07:31:40 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0382.007; Fri, 28 Aug 2026
 07:31:40 +0000
Message-ID: <ffd3851e-3c23-4c6d-be6f-8b88528e05c9@oracle.com>
Date: Fri, 28 Aug 2026 00:31:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] migration/qapi: Add memfd migration transport
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, maciej.szmigiero@oracle.com, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
References: <20260812232842.470225-1-dongli.zhang@oracle.com>
 <20260812232842.470225-2-dongli.zhang@oracle.com>
 <87a4qh46ao.fsf@pond.sub.org>
 <614160f2-2f3e-4489-ac4b-758f162be553@oracle.com>
 <87a4qg0wv9.fsf@pond.sub.org>
 <a23d9e5b-d0ed-4e9d-95ae-e0fda4bb0453@oracle.com>
 <87h5kkvxni.fsf@pond.sub.org>
 <7d7496c2-79f0-444d-a843-5f5bba467560@oracle.com>
 <87zey8ezu7.fsf@pond.sub.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <87zey8ezu7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:510:324::6) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|PH0PR10MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c53f783-4e65-4596-2c9a-08df04d6666b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2itYJPVPM/4SQvTQcY+ro3Q774MK2aCKP8NyVf1ikgcsKET9GfdPoiEd/Yaf+jJGXJKPhu4IQwZ7VARHMe5qI5S892LPuCuY2owRUabj7ti7PHhD1eHo0CB+ApojcV906TeA7VEd9tDXGMCokMeOktfl7smGKtilGbtQXK1Tleni6UEvVGR2YdYdF4RgbCMZSRbdIrFQgeEeXP9yIRJUeZ9M7TYx65D8anQDLH5J852l4tgjVEGP89fSJAMso59hx0qTVJ5kCA1CJZDaO4xu9I2H69uhNkEje6LQ+NS6ZyoBrv3RwfteJuZ5j5ER3x0I+OZtwfTpuETUzT0JhSVZ99qrFrfezijZ9nwga645d3IRnhq6arj0LA726FSCFvbo5YGyR7joqQLuEF9bQzSqZ2nzKnhbpIu3H+xjReJr7rGpeA3rrBW9XR43qzExpqiM/XFjnUE+mIss21midWRPww6MZT0ioEAxTqNiKEPBMqU84YihwSgprxWbKiDcB4StqMemVaiJQgfvE+ixnGMiC9tTY9xtvzr7dPvH5E0dINQurq3/gvoiMBM+2YPcCeo/64XONar7VxqBNzk66iAATfaHX+br05o4lpDVdQt8J0hgmt5bEF98BKs5BdvkesPXHzjT6v9BK/5oqAiQc7x/6/A3h36wyTtN0nasAc8eTAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWJHL1JhVmVNcDhQbzVEamxvNmR4YnRaKy9jaWdBM3ZyelpEejJpL0VSZ2F0?=
 =?utf-8?B?Wlh0NzhWNDJ2ZUpTdXk0WFZqdmtpWTVNbWVPM0VZY1NHb1JRTmluS0FaSTFX?=
 =?utf-8?B?VVJqdFY1VnZCRmlidmJtM2ptUWhQekpCZDg5RERvbkdFQzVjMHJsSDNWSDdy?=
 =?utf-8?B?MnJZVTE2aVZhcFlheUtndzU4RXN0bERxNCtLaC85c3FEQVo4NzFscWNBOWV5?=
 =?utf-8?B?N1RGSUF5OW1vcVdwYlpKbmZuRmg3N3JtTnViNmwxUkNXYmhkYnFaVzZUU0J3?=
 =?utf-8?B?azZSallhOUxZeXVET2tPOVN1OEZLRlN2eUVHTmwxbngvVThmNTdDZGlGd2hi?=
 =?utf-8?B?NkczTDZXRFEvSTJIOXhzaTNoM2dzdTNhdWhlR0dRZ0QvdzNWNGpBdE9aNURa?=
 =?utf-8?B?cUtTV0hOZWQ0ZG9nMU9oY2ZnOEtYd2ZRdFRaN1pOejF6VkpPNitsT0JtOFdY?=
 =?utf-8?B?dlNSN1VZNC9WNG1CZTNJYkMxUzI3dW5vQVdBR3RWWE02enVTTXNWNlhKV3Bj?=
 =?utf-8?B?WjhmcjIwMHdBcGtaODZkQVV5NThUTnVEV2xWM0w3YlpwME9vNmVPcmtPYzA5?=
 =?utf-8?B?S3RXeUkyOTkrOVUrUXRUbmwxSGg5dkpITzBzajFkS2FKV3Y1ekNsei9lSUpw?=
 =?utf-8?B?NnBWc292bTB0ek5ZRGhsRWViWUI0Z21KNE14YzAzWVgrTjZTQUV6eWtKdVg0?=
 =?utf-8?B?SzFhMzlnNEE5TnFyL0d2L1pFS2hzRG9MVHQ5aEU4NithenJHb05GS3hDR21y?=
 =?utf-8?B?UjRNdGNQSGFBZGhXU2hxWHluOFI3bll4Y2dEQktJbUU5YjFMYTF4OGJmdXpC?=
 =?utf-8?B?Z1pQa1Vic1V4ZVZ2Q21Cbk03bEt3ajVONjNvSGZTbFlYaFh5cUZlY05jNlFx?=
 =?utf-8?B?TE80MVdYaTFvL1llblNSbDBBV2Z3NDhobnlDazluUm1abUtRMU42YXdaZS9B?=
 =?utf-8?B?ckxxaGNoT2MwS0c1VVROYmpYUkJjUFhVa2hYc2EwUUZ1emllTWpYOEY1VXlo?=
 =?utf-8?B?aThQWCtQd3RqVkRtYnJiN1pkQzlHRThWYksxMFVwL204NllqN3k2QUZNbHJv?=
 =?utf-8?B?TzFJZ0hqRytqL0hERE95ektVejk1MEZLcDMvRkV4eWJEa25CZVBVVWdVcFNE?=
 =?utf-8?B?Y1A1TE4wbmJ1cmFGcVQ5SjNTU1oyTjBqMmxYblFHS3dXMGdwTDBiWWprWTFT?=
 =?utf-8?B?UlEza2RQOENNMitqR20wUzhzSzViKzBrd1k2MDZINEFJYXp4QjFmTTdlRmRw?=
 =?utf-8?B?QTJ2eUdoMUpqNzRiSGpSa0NrekoxNWZLSjBLNUVNU2FYUUNvSHV3M004NEFB?=
 =?utf-8?B?Vi90TWxCaTRLYklod1QyNzIra2hMcFdVR0srYjZmQXplT2V3Tkxvd3AwWmlX?=
 =?utf-8?B?M09RS0Z5WW9VZWt1eU14MHZSYzh0WXJZVDZualBtTU1BMWlmeGhzMkZjMXVD?=
 =?utf-8?B?QzZwZEJ6RjgyL0J6SEhSdkUxVFlJb01DRGN2ZnpYN1BmbDg2S01aVGg3Q3VQ?=
 =?utf-8?B?amRVUEhQQnNEUE5aR3NxNXF2L25UNXdaNHZyQWlRUHF6L2hVSlhWMGJlQUNG?=
 =?utf-8?B?bXVSQitlL2dHY2JuYzlrTzM0Y0pRb3VzR29jUVJ5R2RycEhwOXZCbldQYmtZ?=
 =?utf-8?B?MHVlY2ZmYWI4ZFFzM0g4QWNsYzBsNDZuaFA3VzVYSXB4b0IxVTkvVi9CeWtt?=
 =?utf-8?B?ZnNEU3dMZlZ2R3RQN3c0N2VxcU13ZENEMmhCUWtSS01pVTl2WU9hek02K0dX?=
 =?utf-8?B?MVkvU2F5K2NVRVpCWkFJWnZkUTY0YzFmM0ppSzl4M2laTWZ0WWNlN3ZZYjNR?=
 =?utf-8?B?MDYyeEJONUorUXhWWGtQTCtZWDBQSmNDNXVYbWdPS0QzSE4ydkt6eWRrUDBw?=
 =?utf-8?B?Yk1ad0xzMk1YRFNZaS9BMFlOK1NFcWcyWGlpWEFqNURSR2srSWdSR3Y4SUdr?=
 =?utf-8?B?ZVREWXBvcTViZDRGMC9qZVpLVXgxa3pzM3NnMktXdWdBWjU0VkFhTWJZZXQw?=
 =?utf-8?B?YlIwNWxTVEY1M3R3c3RCa2RzS1dKbEhQSldMNmlPTkE3cy9RWEZJNU5JQU9X?=
 =?utf-8?B?emtzL2gvQWhJSldxSTcvMmtibnRmbzVHcUQwczF6WjdkQmFUOEl5VEZNQW5m?=
 =?utf-8?B?c3loTFFaU2h6UTRLek9Fd0pIQ1FyVGpEVXVjUFQyRWYyQ29WM053NC8rR0Y0?=
 =?utf-8?B?c08vZGJTQzloSEE2WXYwYVI1eEVwS2hWZUlGNG9UWEFpMGFiNWFFYldlYjUv?=
 =?utf-8?B?RDAyckFOWTIrb3d6cmwyb1RrdHZIL1lSL2RiWkJhc1JLYUdKamZsU3llMW5W?=
 =?utf-8?B?dXE2WXJTVjhnK2x6enl3Wk44emx6T0QyZm5RYm9KL3o4VHVxMGpTUT09?=
X-Exchange-RoutingPolicyChecked: ROuwDB7VWLfBcxW+rRyDFSEPm+C+pVPLdFoIFeUARqDd+iJC7TrY+NOBlhrFaldcvoMPsfGX7EjknFx0A1AQPYBQgGzYgXbtlpvv74eCZH/x0iNpLfbTBnUpQ8IeVKSadutSzBaQSOfkQIu4fJISsmRQq63x+2Cj/1aFWASC4xutUERas10zP03kU+iFOrAjHG84Z9Tt177A5PSeVFmLlzJRk/q0yXdtvKYpHw1lAsfiFwbmn9m3CiUaUnEkM8ugY+TddGUXFCVx6dfFmVVApcpdXGWwE4NL+6R7QFBBDClYbn6jJgvSrjjAaXLQvdujRqTrLeGrEzrzIvVdWZ3ErA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dtVgj4c/oeiWnyTk/8/yuQGZ/oYzyMO5igl9Ds3TKAWtgQ2/2kVagLi0KfYQEIflYwsN1mntU8V3L4pPsr9ZOpagu5UqJo97m899CDAsnjtIf9KQyusGqbpERy4SJCdPiKzqGs/frzC3yFNjFl4xHMwk/+auPyoCAraOy5hpxOPg/fj8tZ8jWO0eqaQXC8lCUxJk8pX6Fi0oiyZKgFnImI2B/xQanOVtvp7i5sDynL7f94USx6H09b+QwyOPDZzUeKKFSLM0RPQikaUQ9QpQEChOD5PUGthoh47NMzC+bgQnPb047aWJgpwyEVhYg438U5QTXHNRQ+MOMCvAUoVVaUQ1AFqpTxikv51W7WoC2dA1z5x3HpiCj3JI6lE2MtU1hpEFDiKeA0lJt7o4HW2JGgl8Hkovns1NR43X9INrH7UVm+6YQ8MRHDkUFv2+MYSvWQ8zzvbmzEkdBKBnYjSOCqPcD0yWAQzX+js/qi64wiIyaP2kgCrl9E+kNu1htgywqJGPh+yTntgTOc4DzD1wzwI0gf9kW//hpj3nvHIIdrQKJTetpVUFeGf2XZmWZuMVmdrFkAJ4GZtc/lpT8r01rVxaGu+iraFP9yIo8bk0H8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c53f783-4e65-4596-2c9a-08df04d6666b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 07:31:40.0959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmRK4iZTgBr67WIowUKlounq7x3JcpgABQSYzbwBDBx3945dgusiSVoFL1eFex+hijgAyxafGmCCICxHlXMo+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608280063
X-Authority-Analysis: v=2.4 cv=D+h37PRj c=1 sm=1 tr=0 ts=6a913962 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8
 a=3jsmu5fK6IfWoImvNm4A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA2MyBTYWx0ZWRfX15RewNIp9q/L
 g1TEsXJ5oXFIqViOqAfpc8dr7wPdWtQK77XzYOBPb/GJlYqfIncROcdNuc479kygGacgiex8H5k
 9bB73a+eGcM1QbmGlGb2U7P/ZBQ6uMoUShfvyPqBPxcQkeO+Kxng
X-Proofpoint-ORIG-GUID: 1prC7sJ8njgiDxXAcjLTqeOOywJJV-1b
X-Proofpoint-GUID: 1prC7sJ8njgiDxXAcjLTqeOOywJJV-1b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA2MyBTYWx0ZWRfXy5Wud1Dh9mbG
 Ganwn+GWcE5O+EIuKgSVTXJzLTlHQBieBmXQ1AJn4uKqjHFaJA7uEc2Fr4HpkWWr3n5tI02ON2D
 xtSKxcyYjDkZpOWRXRV/15ZQ+I1UaNJwV80Oaf6zCeN/7j08mV3nQznuAF4x7AUYKk2TNpIpXOD
 0ymmStZYdlHEeTfNkJwXsAmCRsTkHaq+ukDGjirj1lty7ebYBRBQunVqgDWuaYo00lCEFgvGrCz
 ACTsni6m1TzefFTnZs98JUfhj6cl3Joawcf5ER3qRVjS6/Pbocyo9hNr+ILKzfkcTKvW+qftDlu
 HcyqgoyVkUWxT69Jqvm+6Zr78Mq6l9DgMWskB8CH0/7Dzjvhg7+6R0oQFdJiMUtH9PVr7QGd/a6
 NunvqZSr09WpE3oxyvEVUHuugFVvr+044IoW+iRznO+tKrb7DYHQNBDyxCG1uAmEgE2ioS3D+ko
 3oleNAFNdUeb+173TeA==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On Thu, Aug 27, 2026 1:23:44AM -0700, Markus Armbruster wrote:
> 
> Dongli Zhang <dongli.zhang@oracle.com> writes:
> 
>> On Sun, Aug 23, 2026 11:29:53PM -0700, Markus Armbruster wrote:
>> Dongli Zhang <dongli.zhang@oracle.com> writes:
>>> 
>>>> On Fri, Aug 21, 2026 12:13:30AM -0700, Markus Armbruster wrote:
>>>>> Dongli Zhang <dongli.zhang@oracle.com> writes:
>>>>> 
>>>>>> On Thu, Aug 20, 2026 12:09:19AM -0700, Markus Armbruster wrote:
>>>>>>> Dongli Zhang <dongli.zhang@oracle.com> writes:
>>
>> [snip]
>>
>>>>> message.
>>>>
>>>> Sure.
>>>>
>>>>> 
>>>>> We should also help users decide whether to use the feature.  I gather
>>>>> it's useful with migration mode cpr-exec.  Any other use cases?  Does it
>>>>> even work with other migration modes?  If yes, which ones, and what
>>>>> happens when you try with another one?
>>>>
>>>> So far I only added support for cpr-exec. I have not tried othe modes.
>>> 
>>> What happens when you try to use it with other migration modes?
>>
>> If I use memfd transport without cpr-exec mode, it will be denied.
>>
>> The code checks that only cpr-exec mode is supported.
>>
>> (qemu) migrate -d memfd:
>> Error: memfd transport is only supported with cpr-exec
> 
> Good.
> 
>>>> In my opinion, cpr-transfer could also use a memfd-backed channel, but I am not
>>>> sure it is necessary.
>>>>
>>>> For cpr-transfer, the source and destination are separate QEMU processes. If we
>>>> want to pass a memfd between them, we still need an IPC mechanism that can
>>>> transfer file descriptors, such as a Unix domain socket with SCM_RIGHTS. That
>>>> reduces the value of using memfd as the migration channel, because we need at
>>>> least one Unix domain socket anyway to pass the memfd fd and coordinate the handoff.
>>>>
>>>> If a Unix domain socket is already required, the main benefit of memfd would
>>>> likely be performance, especially when the device state is large.
>>> 
>>> We'd want to measure the performance impact to see whether it's worth
>>> complicating configuration and code.
>>
>> I may create a VM with many virtio devices to maximize the storage overhead of
>> the VM device state. However, I don't think the goal is to improve performance.
> 
> As long as that's the case, enabling memfd for cpr-transfer makes no
> sense.
> 
>>>> cpr-exec is different. The new QEMU is started via exec(), so the memfd fd can
>>>> be preserved across exec by clearing CLOEXEC and passing the fd number through
>>>> an environment variable. This allows us to add a memfd-backed migration channel
>>>> without needing an external file or socket for the device state.
>>> 
>>> What are the actual user-visible benefits?
>>
>> The goal is to avoid the VM state file used during live update with cpr-exec.
>> So, the user-visible benefit is that the file is no longer required. Live update
>> with cpr-exec no longer relies on a file on disk.
> 
> Got it.
> 
>>> Performance?  Provide measurements, please.
>>
>> Not performance.
> 
> If we accept memfd for its other benefits, performance measurements
> might be interesting.  Not now.
> 
>>> Simpler configuration?  Not sure that would be worth the special case.
>>
>> Yes. No file required.
>>
>> "migrate -d memfd:" vs. "migrate -d file:vm.state".
>>
>> "migrate_incoming memfd:" vs. "migrate_incoming file:vm.state".
> 
> Got it.
> 
>>> Anything else?
>>
>> No. Writable storage is no longer required to cache the VM device state file.
>> That's the only explicit benefit so far.
> 
> Benefits of the new MigrationAddressType @memfd: we gain a zero-config
> migration channel for MigMode cpr-exec.
> 
> Costs: we gain yet another kind of migration channel, useful only with
> cpr-exec.  Feels niche.
> 
> Are the benefits worth the costs?  Migration maintainers decide, not me.
> 
> In my (relatively ignorant) opinion, migration already suffers from too
> many features.  Hard to understand, painful test matrix, expensive to
> maintain.

It will depend on the maintainer's decision.

Thank you very much for helping clarify the benefits, costs, and use cases!

Dongli Zhang

> 
>>>> One potential future use case is LUO/KHO support for QEMU. In that case, device
>>>> state could be preserved in memory as a memfd and potentially survive across a
>>>> KHO kexec. We won't need to preserve anything on storage. Indeed, I did some
>>>> internal tests using memfd to preserve device state across kexec although using
>>>> different implementation, and it worked.
>>>>
>>>> For other live migration modes, or even local migration, I do not think this is
>>>> useful. For example, saving to and loading from a file won't use memfd, as the
>>>> QEMU processes are terminated during the this process.
>>> 
>>> User documentation should spell out when memfd can be used.
> 
> It does: "This transport is currently only valid with cpr-exec migration
> mode."
> 
>>>                                                              I recommend
>>> to make it usable only when it's known to improve things in at least
>>> some scenario that matters.  Code should cleanly reject attempts to use
>>> memfd when it's not usable.
> 
> You showed above that it does.
> 
>>> User documentation should help users decide whether to use it.
> 
> It does not so far.
> 
>>> The commit message(s) may need to provide additional detail on how
>>> things improve.
>>> 
>> Thank you very much for feedback!
>>
>> Dongli Zhang
> 
> You're welcome!
> 
> 
> Tangent, pardon my ignorance...  We have MigMode @cpr-exec and we have
> MigrationAddressType @exec.  Both involve starting a new instance of
> QEMU.  How do their use cases differ?
> 


