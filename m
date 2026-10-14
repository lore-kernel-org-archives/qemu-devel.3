Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6E6CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH2k8-0000Jj-65; Wed, 14 Oct 2026 13:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH2k5-0000Is-T2
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:26:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH2k2-000502-Pt
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:26:17 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EF4FJL4167069
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TlhXdUVNZOaqaTE9dOIdhq1YTWPu4xMWhK6VXVWA79Q=; b=HqiOgssqJWOb76Ds
 Ib1/dbQXxcVsi0TDSvecRI77Nb3G6DAZX6veqJYBResy1O2bKhXQKgVClKcvz567
 zw1fs/GFSXyCcG13jNb216fo85xs8CuITKb3C+zCkJ5YK309KDtogb7UEHL7tnyf
 1vkdULMJXwdPv7EbTW3etXVcZLEiSPl6zPxAhMY9bVSwJVcO05PMhB/L0bbOf0Yy
 QkFoebFFM9xGvl5IQdecmykonVBFN0Z+QHfkfgIFTk+Aa+HBCZDKUmEbohWFpVAB
 jDplCTjyqwveHQyPL2arBBISLNhWUYC1pITYdOK1LCx8TRTzrKHpIffCbDXW1O2+
 m99REg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hac230js9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:26:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso6712711eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791998772; x=1792603572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TlhXdUVNZOaqaTE9dOIdhq1YTWPu4xMWhK6VXVWA79Q=;
 b=Ln/DLRrS7i9y2mK19oK3aQC99P+I8TLFyjzDVrGBkt/nOnkcQylbZ7Rn8+eRSUDcqC
 iydMKeh+QZI2a9W/CJ1YMTlQjZMTVfRzw3Vvpq3M0oOREVA2SoP3USUtrDLqif5Y6f/7
 nvb8VuLBxQwtfLTRbVZKWSD0AFHslOjlPF/bArrug30QbWE808RldZ+SO+GNeOL20c61
 V4bMbyq67tmadaMIe+04K89azrDwGsf4mnN+vUF+lwavXTFErtPYh0VE54Rqi8UY03eF
 YL8PEje3x3pL2uDCF5qtsmE4sUMVl9+nmcnT/jkOpefk7oj/IkMc1wQEHzC630BgKUrp
 hwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791998772; x=1792603572;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TlhXdUVNZOaqaTE9dOIdhq1YTWPu4xMWhK6VXVWA79Q=;
 b=hWhkhjI2/HuoqyGIYS7CcHthNmS+2k7P2u8fgemRWpvxETHAPEOfIE0Rgw2PnRXn2+
 adnGYgC7UWZKQhkycf/gt4cmrWjm9hKBW0X7HFWn6jnnI8HZASei2rnYtbYkAdQ1qbrD
 bcLgurywdbf+BeG96YaI2yaYGS0UuMblfDM9NFcvBcapvCyIQvGYCVi3qodwp1eajDcG
 ryeKxGQkmaDrwISr5Y8ZRTvpKz7m7bzwdWJaBsZZ42QWN8AXZoXfIzKaGRvmSdC8TJBX
 4a0k/s1nZTUSkO5XdeDa3k8JMF50QRwCWRfu62WC1FmYi6YLebe8piqhOzpM6j5tEPW+
 eFPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwarEXPdOnUW5Gft4/XqOtwjbtWYavL/r7c1GktGrsZ9sSXcz7Ag7dYwcY2d5zN/Uq5zdlccz3KD3NH@nongnu.org
X-Gm-Message-State: AFq9FYJMU/eNIXRfc27oXHnGH+sTET89ZjBHg1V9v38xG4sQgJY4TcEr
 w5g+TeDlnP4TLaQBjfSxvIIG2u8r7fvukDjXFSTzgpg2PHII0kpizRnX0xYkHbS3HItEPdLSZRk
 n9XPYHtGVrEZg10EqygP/8D8P89vnA8whW2hU184JHz6qGftSd/wS62hoaQ==
X-Gm-Gg: AYBFou0BLHDonXsy6Ue4Eer2bBl0EIoG8+AuwB2a/EL/SxU8kmVOEnBfLrCocUXzsN0
 xBFssyGx+cSNP1Xf40wDJr+2O9/mjJ3vuVLNbCiCwZr2HnQ4dsN8jKmodg21S61WZhLWDrPUKk+
 OJsZ5ZuHmxU9HG85FMYKrncXF/yaV4J6s+nRG8CuheEQdVeUHZ/eSbURU9H1Ybn16VkqrgFbwos
 a5upgt8RwSqjid5CSCoRdwQXD57RAqkNvYMMbApn7QI9IpGsyVGdMqhM121fSt4btLqo/yizCXY
 7yG06j6kzoFwKLw9kx8TKi9hpEqIPRDlz4NtqQ8KF+Ln138qrnnHhb4wqB2531nm8J4A4xGhJ/N
 0V5SnXoKncK9uD3IKOZknjBsScsTylSkfB7a2GEmAim6gbdxzVk0yAujer3mY01rm6+Wygw==
X-Received: by 2002:a05:7300:b913:b0:358:cb31:4277 with SMTP id
 5a478bee46e88-358cb3169e2mr25913377eec.28.1791998772057; 
 Wed, 14 Oct 2026 10:26:12 -0700 (PDT)
X-Received: by 2002:a05:7300:b913:b0:358:cb31:4277 with SMTP id
 5a478bee46e88-358cb3169e2mr25913302eec.28.1791998771444; 
 Wed, 14 Oct 2026 10:26:11 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b29c2f861sm37806266eec.11.2026.10.14.10.26.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 10:26:10 -0700 (PDT)
Message-ID: <435a282c-f3fe-4d68-bb82-fc358dc7b771@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 10:26:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/34] qapi: add missing Linux user-mode targets to
 EmuTarget
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Laurent Vivier <laurent@vivier.eu>, Fam Zheng <fam@euphon.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
 <20261014093152.834-6-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014093152.834-6-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6acfbb34 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=sG8BiHsngPr4fBh7ZusA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2OSBTYWx0ZWRfX5gVPUR99IK3K
 q6GS6QS2c+j1StrRt8VEPzZJGdIyt6kAHBkdBohTnYmQbQl29prDkxmkEwKqmbEKozXTOyw5gIx
 GzaYqEkDk5AqlsU7fIZM6YpCd00CkTg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2OSBTYWx0ZWRfXx/7kWQDRaE6s
 3QWM4whTFMemcUD9yjsHp34hU9nRW0nue9d+aWpFWxDgF2mLIZ/X35HsENUnVa73iHnV3BvKhnb
 PLIkumQU5iwC+aUxfzCLRVXhj34tnzrYFSYZThijNOu+oC4vbuVtF87UI5w6d3PqtNM+HaWUJqT
 xifaRxqsjiCEtVEObQ61eGBtY6yM9MmO4sqJVx33PrHhXDq2kn/2HJlWN5QJYlxh61nXKeJmlzJ
 XIJYOun3a8o+ztmSGHKKOAF3iqHCC9DaAZiOGhxUMtskMMAW0NFY53UodDOvu0qmbR2rwLhuegS
 zfaIFCtsf+mDpf3afgHdcKkq+ZZq8eFWAEgmP9ojD3JQTiBmkQbXtqBUH+2tnkkZ+4He+a53eUV
 D8U0bgJrmsGBzROs1LcNC/Pjpp8o6OM2UWn0bdN+ZppjXKjZodKZrBx8HpkCtL5bKvCzMllU5R+
 Ajxm4+0F3Mi/elE9Pcw==
X-Proofpoint-GUID: f-7EiLwEzqnJhOyV-C6WFUbgcDm57u1k
X-Proofpoint-ORIG-GUID: f-7EiLwEzqnJhOyV-C6WFUbgcDm57u1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/14/2026 2:31 AM, Yonggang Luo wrote:
> This usermode targets:
> aarch64_be
> armeb
> microblazeel
> mipsn32
> mipsn32el
> ppc64le
> sparc32plus
> are not in machine.json
> 
> This is a prepare for directly using TARGET_ARCH_VARIANT latter.
> 
> Also get target-info.c to be compatible with future TARGET_ARCH_VARIANT only usage.
> So that we can define TARGET_ARCH_VARIANT to target_name directly
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  include/qemu/base-arch-defs.h | 13 +++++++++++++
>  qapi/machine.json             | 25 +++++++++++++------------
>  target-info.c                 | 26 +++++++++-----------------
>  3 files changed, 35 insertions(+), 29 deletions(-)
> 

This patch indeed allows to have a unique definition of
TARGET_ARCH_VARIANT in next patch. However, it's absolutely not needed
for anything else in this series, out of cleaning up one if in meson.build.

Is there is any concrete reason we need to expose linux-user missing
variants?

Regards,
Pierrick

