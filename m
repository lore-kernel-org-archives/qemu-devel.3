Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95284606B452
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=NqZJiFcT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzt8-0003IR-0k; Thu, 05 Nov 2026 11:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xOzsp-0003Gh-Ck; Thu, 05 Nov 2026 11:00:15 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xOzsm-0004AN-QS; Thu, 05 Nov 2026 11:00:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fC0QnL2pZazO7GLp8vgNnLgtUecznA5hXHpPtY/gSjW247r9Nc91uU2Frgvx82vckbqw0fhCXHmn7shhmIKcZm/70v4sAgS0zw+1MEYPLdpwc9sN5dXCFZNWmMF3j6dKyQfeT7yzDO3E4WYvIbOOIZSj7Gbn+FLP0WWBW+x+Ofi7R7YX+W3LSbJKSbrs7oCUupQTaYwhQr2OKKicjoUrfEbsnoTcmlHa5C0jBPFV+vaRzoxMxZM2nkWg7DNQguoXB4PyfHvQTUxUS78n2Bl+/kiwdD3/tI3BOX2no6tXKFoAR1A8Kt6fWrD2GJGIn0c/im1NitWaAA7WHwnp7TulDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUrVPUKG4hcA7R0+G7H2fiIMaHcstM0B4zM14cv+e2g=;
 b=WelxhTnF517LbYwrrest5lQeuCEdYK7MgxW5Is8fDrsbe8caYGjIr5KZdI63F2oiAoaHomDy8gXldxA/vuHKa+Vv+/b7LUDgzskY4y23djQ1vsGyoJxoizy4QORq69YYJ1Fm3Pd/IoOdR51Sr//MhiYxOTtUpGpBh5SsHMbfguJd5aNarDiVZuJYNAtgAUndnXnR3OwcQpV3fbwrnKCZlpfxSCb66zv6Guz6TXPlD/+Iir2ACLwnk5Wh4dad5LRoelgQs+HYkHufzm8LXF7305jfCJ8qZNWTV97ROi8PTTSH+a9O+AlM6GTE3kQ5DWdJ5kPn4/osSsUyQ0taYRdnUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUrVPUKG4hcA7R0+G7H2fiIMaHcstM0B4zM14cv+e2g=;
 b=NqZJiFcTVJQt6jur1TP3hHMVns0hZ9AeP/U+ztSZb9lhdUF8i87E+EHgwz2RwQ+IWV8B/4WEM9I4QX9ZHdvudzTF7FPo2FAy0ikOz+2kVEWIvpAYHrOD0NsYsj5FwRFf/wWovary604Sj7Yaape/y74udkdJZkGdMNl8yNuWYW5Mj0iflPi0+fUIEKX/6dVLesfb1Ix2lMN+9BncpSl+WZ69U0jX4ugkcuVbATSDM6xaF5dGXxyAlevuj2olDJzuqEaPrjvJnE6GhksOq2fJLH0n/kCPhWbRyrkG2st1WMpfeI+hgBdpUW72is15cR/sKFey5675od8+z+NrG3MpcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9443.eurprd08.prod.outlook.com
 (2603:10a6:10:45b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:00:01 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:00:00 +0000
Message-ID: <df9d05bd-715c-4a6e-9e29-eeafe416083b@virtuozzo.com>
Date: Thu, 5 Nov 2026 17:59:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iotests/290: add test case to check
 'discard-no-unref' option behavior
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 jean-louis@dupond.be, den@openvz.org
References: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
 <20261027104441.830212-2-andrey.drobyshev@virtuozzo.com>
 <auoDiqgIluYOUr9F@redhat.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <auoDiqgIluYOUr9F@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::21) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c1f5ab-5dbf-4a06-a552-08df3b55d8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|3023799007|4143699003|56012099006|261026121527099003|261028144727099003|261022105027099003|261022115727099003|261009223027099003|261022075727099003|261102123227099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: blv3R5FqeCqSJG3/tRNPiLmsxoybhjWEj+GzbCGRof+RZHWlaxHjuS8VX6ICd6TsBUVYQ/gNBWxj3N4svA+WwNoary/Ay629KENVoUiByidJEtoq3UbnFiptbcgbH4dRXePuQNlWKBSz+hAknCpgNu5AxjT/+8r93FM9pI7W2/ctFEGCDCgiXwFRdhdn2g24dnyBobvQTCf9ySZ9D0hQDtp2dmArwdchQx2c20/0Ta+XZgfBItPKPpLTDHq9LC1oPqfJ9W4W1adRXad9IQ4Kut0nHfPPKs7XuJZ/STN8vFUqWPBSeGJbvZFLKWRDVT7nzgJOYA3CE9jf8GXJmvgCQDfu+PLlLWwiBaBTgZbcqwvQTAvUtOBO48i9e0dD8E81VKur2SJVmBLiLaj2PoP2e2D/SLPbmknQ20ro57YRpi4BM0niiCJhAasg6RKpR5po+zOpwLP/tEubi0PUbN4VUQ3myqFIOb+kolMCQiyvBy+Zt2PnbLUEtwQuRdAV+EmtEWdM957NASK2MvuPsZnY/8Va9g8nw4/T2PPG/pkdw/ArD4cN6m3XtqFx1ZqBcwtak0RENstILV59XY1DM2efn9FDXNnsSmpnjRF/SSXMT/o8E+og5c21z7nAOeFiiBX9oKOGx2UkLNvwKJZ566WXvqqbMgaNo+RAYnYkA/k+u/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(56012099006)(261026121527099003)(261028144727099003)(261022105027099003)(261022115727099003)(261009223027099003)(261022075727099003)(261102123227099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUhRZzdudnlHSzJReW96VitvUTFRZEdQejJYeWxUSWg3SjdhYzlZYXZVQmR6?=
 =?utf-8?B?MW1zSEUzSllOMEljZ2Zzb1hvczl2eGdQZ2Q3aFM5VndlUGZUQjVZRUZkNkxS?=
 =?utf-8?B?RmgrN1NKVkMrNUoyN3hVaDY4WitxQTcrbnFTYzZhaFMzRHY4VEdFd1pCOFcy?=
 =?utf-8?B?OWVtS00wVmJEbU1RN0JqakFkcEFmMWNVUVlnZThqNGRJTk5XVjM1MEh0TCs2?=
 =?utf-8?B?VnBCSVl5TXVaL2w1SWFqQUlreVplVXpDNUZZemdrM0lIWUhvczc5VDlSMUp2?=
 =?utf-8?B?U0pvRTVrYWdlQWtEdXQvNG9SNGMyK0xjN2t3ZFZHRmR5UUxlaDJZejJkSjBQ?=
 =?utf-8?B?UzlSRWVRZFJ3cUxHaGJ6MGw2TTdiV01uODdrcUR2MmhHSzkzdnJYVytXWGYz?=
 =?utf-8?B?dm92RERxMUxsYjdXOTNMOS9FNi9xcjhhZDNRYWFQa0Q1UWJPN1FpYVoyZGd5?=
 =?utf-8?B?VnNOSGYrRHNRTExrdU40Q0VGRkVaUW5CYTZuR09US0g5aEkxbFlCc1N1SlF5?=
 =?utf-8?B?ZThFcEFRaFRyOUQvcXJQZTdBRFB4emJMRklvcEt3R3M3dWROV25CMEk4Nmo4?=
 =?utf-8?B?TGNtSmdacW9OeXc3d1FDSjFNb0pEY2lIZXI3R1hSU2s1Z2FQa0V6amRPdDBG?=
 =?utf-8?B?UFZpdnZLTG5CT3R0RUJ3MEdBdlV0YzRSYXJQWlQrRG9kLzJOcTBLV3JVcVlL?=
 =?utf-8?B?YXBNZ3h4U2dySHNrZU0vMXF4U2Uzc1FPSUZVTWM0bnAybkt2ODdLYWJaRXRj?=
 =?utf-8?B?ZWV4ekVQejJFOGVuUXpLV0IrMDh1UFR4dTVuWUdPWmQ2TCtYTEpFK1pPdGEr?=
 =?utf-8?B?RUVPcW9ESGxlaUZrVXlOd0lYdEk0N3d2bTNMVnE5OTI4Y0lDenByWkZTci93?=
 =?utf-8?B?Y0UrQjVBOGxmaHhVaVo5c2lDRytWeDYycUEyY2dnQmcrQ1VFckdlRGp4eDl6?=
 =?utf-8?B?SkgxV2hXSWxXckhyRXRyLzhSNkVyRnp3YTVNOGttenZDTmJ4Ui9Pcm1KSVgr?=
 =?utf-8?B?aW1CMjdZeVVNWEVvUnBuMmRiZUZTb2VWZFAvdndpNUU5RG10RVkvMjJPaXFC?=
 =?utf-8?B?YkR0V2ZFaXEzNHdZMnVFNFFKQnNBR0pCekhTbmYyUXc5YngwRk9Ib1oybS9N?=
 =?utf-8?B?L2djZC9DNm5Cb01FSTF3elRNbSs3anpvbmwyRlJQOU5JbUpFSURIckpZRm02?=
 =?utf-8?B?c01JMXBESHhvVVZmS3hxMnZxSFlsajBFQkdFU3FadDV6UlZsTC9CbGdac3Yz?=
 =?utf-8?B?YTFtaEVhL0YxN24zVXMxejZRQTNVUGFvZVRnSThLakxFZU1HWERoN1RaTFRD?=
 =?utf-8?B?Z0RBQTNOaTd0U3NlcnlLY1I2bkt2TnoxOUlIZ2pMUDVUeS9yL0J4eHY5S3RM?=
 =?utf-8?B?cHQvSENEUUV5YnJFcnJSNnpBQnJKUXhWSVBQTkF6OG1SVzFIZTkxOFpkb1BI?=
 =?utf-8?B?MFB3UFZvSXBlYVJ1dm9vYUwzYkhqWGUzNGFQRGxQUTZEL3MwMWlzNW5ra3hh?=
 =?utf-8?B?c1FjTEkycHgrZmpxd3ZqK3V2d3dXYSs1WG40bENaWFZKbWtVS3dmaGhlbjgv?=
 =?utf-8?B?dUlDbG9BWWNLdy9hMWM5TUFuQUdNM3BLUTRaY0M0elh1Uko2SEZLYmE1Wmhi?=
 =?utf-8?B?MHlmb2RDVWJMelMxQjIyZHRrYmVoZ1hCYVNQQ3JEUUJwaHJheTl5Wk9sUEhx?=
 =?utf-8?B?dWZZb3dtSktqZ2llcDBkb2xvVFRneThLdkIzSnJtWjJtS01ySGZ6MzdUVDBm?=
 =?utf-8?B?ekdONkNEM2ZUMmpDRkFnL3NwY1dyR1AvamRFaU1ueURPUmlXSkc3WlRTRHNW?=
 =?utf-8?B?UkFwOEJMak16V3BOSWFzbUc0TFJtWi9rakZtQzBMMlo5ZElaTlZTWXd0L0o1?=
 =?utf-8?B?VmZRbTlwMks4bWR0ai9Ib2I3bkxyWU5mMElia0tGTUZRcERQaDI4MkZOOGhY?=
 =?utf-8?B?Y24rV2NEbmF6TXJObXB0bXJxY0g0OEx6SE9TZk9SeXE5VkFBa1U3UE02em0v?=
 =?utf-8?B?MTF0SFJQVGZKWXExUzIrSGJWS3NVcXNKWDdHTW8xcXF6dy8vMktlREY5K1Bi?=
 =?utf-8?B?MjZiZTJmNHJnalZvdXREc2RNM0dJL2tRRDFQVFp5aElCdVZIMWZIcGo1Q0ps?=
 =?utf-8?B?VmJEYkpRdmZOVG91dHMvTWNmRVF2ejlBdXFvY1JrUmlaZTJJVk5hMXZCa2hh?=
 =?utf-8?B?OWh0citwbjM2cVBkV3F3NGtsTDBaRXdGNlJYd21sbElpcnU4R2ZrcUhmQkkx?=
 =?utf-8?B?bXExcjYvMEFQSDRnMmNhVkV5Z0tya005NFdJUUFXY1diM08xL09IcGROSGdy?=
 =?utf-8?B?MVlrZlpEY1dRVTVWblROR0w5ZlIrVEtCVHFMTTQzVllNRlZQdWhjWXM3ZVc4?=
 =?utf-8?Q?sVcLRrpSle6RmVGA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c1f5ab-5dbf-4a06-a552-08df3b55d8b1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:00:00.5239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ued2kNz4HOgGnOgEcSfYjHgPomVML24FJ0LNX9WxNqm5HK32eW+X1rkM00qBrUMfDgtzQchBBVzYEIA2iNEzVCb41aGGM/dgWJHTpEXx8j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9443
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 5:53 PM, Kevin Wolf wrote:
> Am 27.10.2026 um 11:44 hat Andrey Drobyshev geschrieben:
>> We basically fill 2 images with identical data and perform discard
>> operations with and without 'discard-no-unref' enabled.  Then we check
>> that images still read identically, that their disk usage is the same
>> (i.e. fallocate(FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE) is called for
>> both) and that with the option enabled cluster is still marked as
>> allocated in "qemu-img map" output.  We also check that the option
>> doesn't work with qcow2 v2 images.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
> 
> This test fails with -fuse:
> 
> $ tests/qemu-iotests/check -fuse -qcow2 290
> [...]
> 290   fail       [16:49:10] [16:49:16]   5.3s                 output mismatch (see /home/kwolf/source/qemu/build-clang/scratch/qcow2-fuse-290/290.out.bad)
> --- /home/kwolf/source/qemu/tests/qemu-iotests/290.out
> +++ /home/kwolf/source/qemu/build-clang/scratch/qcow2-fuse-290/290.out.bad
> @@ -77,7 +77,7 @@
>  discard 65536/65536 bytes at offset 65536
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  # Compare disk usage of the 2 images
> -disk_usage(t.qcow2) - disk_usage(t.qcow2.nounref) = 0
> +disk_usage(fuse-t.qcow2) - disk_usage(fuse-t.qcow2.nounref) = 0
>  # Check that images are still identical
>  Images are identical.
>  # Output of qemu-img map for the image with dropped reference
> Failures: 290
> Failed 1 of 1 iotests
> 
> Kevin

Hello Kevin,

It fails indeed, will fix in v2.

Thanks,
Andrey

