Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4014E6B244
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 10:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6oy2-0001R2-JH; Fri, 01 Nov 2024 06:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t6oy0-0001Qp-MN
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 06:33:20 -0400
Received: from mail-sy4aus01olkn20831.outbound.protection.outlook.com
 ([2a01:111:f403:2819::831]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t6oxz-0008EJ-4t
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 06:33:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DK6FYjATNRjSgRHuzaJ0eQWV4kNbbaTlD3Ru1GYvT1ibrofovZSijWfZmIyn/rlnHQi0qZ0UAIzyKjvg+wsgiGggHn+51dOvNbLdIz2wdo2V39WEdifIZz9+XNyXBmUcUYJmIXUqJQDPdUNjiOazkQqx5AJiDkyOR9kf3mAub0+MbNZ111KJj7U2fOJWYaKhXJlsdHNY8yFmLSNEmj3UKZ/r/SD6i/L/YDq3N48PTT3eis+O2/JnQfKkmctj18wsv1fl7KmEha5nvuST4sshhIJIE2y6F0rW2PCgv7dz0ls9dsRd9E5xqw6hezgD3ZGjFrb6aR2eHX4Bf95Cf/zR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SahMM8GCyFO04M219lA46Wsv1FpvWke7zNJEMCQjUG8=;
 b=BZKdtD/cBXIxIYPTSVTLVj/F7A9/FroJWXXVNfEpw21BX7E+sabqRh4Tg3qVX20SnpDE29STLIdjH9M3+zRbVnXcvSO4N5LlMp/JiAM+u6Tfca7bXk2cj0THxL/qSNxT9AP0wUj02REB76sCoebPFwRkz1C3SXDXrFCrkVUlxXwqkDYZFrk27y0oScRLajikhjEK3phyr2TM1Bcgug4z/vwaMxbPlF5teKX7+N0LhYK0u5dOFgrfLi5eBUggas7w0uuhsvhV7R2h0KdFnKR0fv5uQ0Cld5GtlMf9zK2VNYCBJpKYAvkSvP7jZtttMx6a3vkTaHBFgeglpgxxLkuxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SahMM8GCyFO04M219lA46Wsv1FpvWke7zNJEMCQjUG8=;
 b=WS7f6V4qQ0MnLlbhukLP5Y2RQk2k8whAkxJoteBRHVcTroDVtLBNunZDLd56k59wgB3OiXAbrL+mZnwH44MhmZMztpuvSWJh9H38unxWNbJpjsVdiEpIyVgWq61Q3vnuqdRoZJ3LTafqKvMFaK8BZTfNLIwFd/ABMnlTlDMRQpD0CmwTAL64Hb0tP5UgO+ku5jYR1w4sJh6Y+iLiBLTinSCLkHpn6dE9it0W5bDRmKRfsedNxfBBfvhuJ7j2ukhAc2ZGfABJeeKGI3Xp530VProCtf4aM6AQsgqluj5NToG6/Jzd2qh1T1NvXLiHTTHvGN1huFQ8ow/P/q6+w3pxWQ==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by SY8P300MB0249.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Fri, 1 Nov
 2024 10:33:12 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 10:33:11 +0000
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-15-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 zhao1.liu@intel.com, berrange@redhat.com
Subject: Re: [PATCH 14/23] rust: create a cargo workspace
Date: Fri, 01 Nov 2024 18:21:42 +0800
In-reply-to: <20241025160209.194307-15-pbonzini@redhat.com>
Message-ID: <ME0P300MB1040FFFE4020FC209D2FF1A795562@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <87ttcrtfab.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|SY8P300MB0249:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d4c800-4d74-4f3d-39a6-08dcfa60955c
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7092599003|19110799003|5072599009|461199028|15080799006|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BBgdVAerxL0ZWAcFhVB84L51LG8gOVqAKcNJyT0j76o0cKGsxrGWjLzM7WMC?=
 =?us-ascii?Q?RdiKMHhA8UzMtOVrY/rju/p6FQkmLcFWl94TlV0uSW0ei+v5I++Q2hdxV75L?=
 =?us-ascii?Q?LI98QvLS4tg3ijsxoTUV+k9Hmr/ywDXRzO9oTDrAiFG/8QHd8A30YOAVpQz8?=
 =?us-ascii?Q?Jjv5f/VkE/wNFJRqjBVLHbSh2fDzrvkTgepRkel8GpsrRHCLKT7eVYSWsQ1b?=
 =?us-ascii?Q?Hwsu/oeBFtUT5vRrOb6L2CWGegORzy9CHwnGkj3AuNbVccdJEzWDKzO+ABwN?=
 =?us-ascii?Q?nKGno/muYv6i+761JgANBPNlQN8Smexgy02YtXTgtLK8jFthVO5SlIPr0eSG?=
 =?us-ascii?Q?hDBzwBnIK3JOefMyIY9Ssieiczv3dQrGAdJ8LSLEp4E7dkkNz/q184BFB5c4?=
 =?us-ascii?Q?UBmckvafJYkWrNwhJ0hlbn2tVegXeUb1QiVxXd+R/aGgQhIHfjWZxUo2kmIU?=
 =?us-ascii?Q?qAcaiisQFo0lhEx1pU5nCEk5sPuRdj64fYkw64Vs+HuHMrEfViIzxXTvi7Dk?=
 =?us-ascii?Q?ApReKcjPqZVIgDyTMYvz9ENu9hYFw/ceM+wwVZvOiJk9LztXu7it/+FcnbB8?=
 =?us-ascii?Q?gKr+e2z3gboV05NmxCoc8KGHTUEwv6uXiC1MYuCt9EXYrXFS26PTCUu07Knl?=
 =?us-ascii?Q?MPXXiTC63yK7yVyvlxS2g3slmp7YhkbIwlwTQTA2UayfDoFMdx1iu0BpWUf5?=
 =?us-ascii?Q?Qs3BfX21GeC+r/55iyWfWgmbchsaeM0cn2DydpdEf3tBOvYB4y9AMwkrMuhC?=
 =?us-ascii?Q?ALP8TRlB1xva6q4dhJkL7JnHBNNPG7bZdM7D3fgoH8X+DKbPG+E8AUjpRjsl?=
 =?us-ascii?Q?HR+CD66UEdhoCxa9OcmePSKG//RCe6ifld+m2ny3lE3/KtNsz//wWmqlaWDq?=
 =?us-ascii?Q?T+hkDPirFMrX1wmWNApaqya7Mk1fGuO5MMBrLuXpOS5ivA73vnlBlu7vQ94b?=
 =?us-ascii?Q?cor5OW/7WxoDxthAKJrlnGiwHfpq8I9TJ5b70JlOM1gusT8pONOD4GHdSdTC?=
 =?us-ascii?Q?v41ncx03IQDKyCQFw1+AVHdb460WOdgCRx83hMXCiSKKX0I=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lDsY6Yr0Sio1TfqdkHDLmtw9457dvZZ0o+HxaX5WkHPi8MfXA/AlCBQInCO9?=
 =?us-ascii?Q?KWwr2RyZf0GnXy2zYfRsOyH5L8f93Yb8WF8oqtEQzSfe3quQPD5840yslpsu?=
 =?us-ascii?Q?BODXVqlQmLqz4XnPwj1JP4JgUjMxqrDYnEjkkMWvzT2Yh4LSyDbjuCCTYPiu?=
 =?us-ascii?Q?sgZWOHMS4+K/QDoOn4GlpkR3aYpcqeT9Za1Fsar8ed4aJDu/3e4rfbXgggJf?=
 =?us-ascii?Q?NLmHUVsNoh5Ye4KpptDJ4+dMUCJ9v8EMDwUdL6Pm3Fs6WAygCLTdJDd6RUh/?=
 =?us-ascii?Q?j96CHn6jnZFHMDRf/zwpl0VjYmvfUnGrVNTCBFlAMxTWlvFaZNgFD2kbofo6?=
 =?us-ascii?Q?efSofzGtHgvssP86OOnfsC0tZrP5ysYQPT9OQ4FR0JLiRd9Hm5ZMWPfs9qcv?=
 =?us-ascii?Q?BwtIZgEDyChLosnkDWBxzgCknwmQGVkEz+ro25bMWtDgmqrzpdgKfHQXE64b?=
 =?us-ascii?Q?jmhqTEy+LZgVvKynXkg9utUHJUQcAi5M6v4D+QiuE2Rs83JFZ0AKWnR1YThn?=
 =?us-ascii?Q?ddaUiUflGkNZYL7W7SoqnBD2K1LwGNp198g3UYdkqLH3XITYSET/f0b4n0Ae?=
 =?us-ascii?Q?sOnQpIp3NdAtgSC1nDpmQdvZTMFplaBIIE5Sb//X58bUDSukJOCtLx20bZWP?=
 =?us-ascii?Q?20dF8L+SamJBAbtS5KMXBZkfaGzpDOFwFVS+63APJBAB04PEcpgCs66a6j5s?=
 =?us-ascii?Q?EaiGzrcxfKgh6+WrrRq+pgooUKiApqG9PTPH+c4z4iv8EZI9XXGASDuJhNdz?=
 =?us-ascii?Q?pk9sgafU4CeBkwVKDxILfWiSF8rg80vj+7+lJnyfU0eV4dFUJCzf13Sb/tzT?=
 =?us-ascii?Q?8vloskGj+pVR0nEPsPxbfNDTx7H0qqT/nnaN5fK2UmLLLWElvMlMLekf4Oaz?=
 =?us-ascii?Q?dcsZAP6eNwsoXVRSbUoKIFEgKVXhP9L47QxLG/kwdcEPe7hBWtztZSvVd2L2?=
 =?us-ascii?Q?ers+fhxtJJzVuhLxs9IDk6+7h9s5SFoKuzHFCPWKb8h2guOw9I5M1xfBM9br?=
 =?us-ascii?Q?qn00+oKdts5f7Ljv6f+SyL4OMldw31vla5eqSpzMd5Xtp8egiBqbp68HMjy5?=
 =?us-ascii?Q?Zk2tNzd6X723Bg8MiJTmr8KhyhBmujf/oxuekkF80ZePxLq2RccWMxh4JEg8?=
 =?us-ascii?Q?X+v8XRpL8HDwaqEWpFp1wFsjmMZAdmJjus3f3NQQpK+H5Yc0LJ67vLGf4o03?=
 =?us-ascii?Q?kKmDtWb5X2iU2izZfekqBxliPAg8d4X3b8DA9cyd3QtQrC1NVC9bKXeH5UA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d4c800-4d74-4f3d-39a6-08dcfa60955c
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 10:33:11.1443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0249
Received-SPF: pass client-ip=2a01:111:f403:2819::831;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> Workspaces allows tracking dependencies for multiple crates at once,
> by having a single Cargo.lock file at the top of the rust/ tree.
> Because QEMU's Cargo.lock files have to be synchronized with the versions
> of crates in subprojects/, using a workspace avoids the need to copy
> over the Cargo.lock file when adding a new device (and thus a new crate)
> under rust/hw/.
>
> In addition, workspaces let cargo download and build dependencies just
> once.  While right now we have one leaf crate (hw/char/pl011), this
> will not be the case once more devices are added.

Cargo workspace fits our use case very well!

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

