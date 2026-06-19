Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17657CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZfB-000542-Mw; Fri, 19 Jun 2026 09:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1waZf7-00053m-1t
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:53:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1waZf4-0004ld-LP
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:53:36 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JD9UBn259686
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 13:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ACdilqkn/GL
 isd3wqAO2X6VYonz1Hu8bOa4bCPW+Aek=; b=p5INpbwLZbYSkokKO87pGQjK+mf
 WkzIF9ej+b/KekgmKMCSy0QH3918wZxFSTg0Q8hQOV2prZDaxXRHS9G9JMBZ8gvO
 /ns5rzCD5Ve1r4vl5iojfCK02/TOOPvfTVseaoN6WzfHwGrD9J+rEiMKsEpOjL1J
 V8d98XnuG7kU6CQ/f0S5oKithe/jk1mKh3zuuUCgGpkj6yMAlWZQAN3q/7gskL5i
 ZMw1V5mnsuE5WKWLiNdntPVHPBK1vTMbJWmcphhcLsXLLAoRhbNP0I6KBIyd8BcU
 XYDGTbWI71pUHDbeQsxR6Llx6bPKySCrT9qFtKi5fU2MXJw6bR5WRrbw2PQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp673brg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 13:53:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bfe262ef0so931216eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781877209; x=1782482009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACdilqkn/GLisd3wqAO2X6VYonz1Hu8bOa4bCPW+Aek=;
 b=aI6i9+EQ31Uw6mW2AmunTPZItm+zD0OgKenda+6nD7l4j5xWm/KFn2H8FAEI7k76n/
 YbkDUyVhezFnziVDcn3dc2L7q2zw0hp7Brn11q+aEE2TavDEmScC4kULgDb9R0RM6Qm+
 Z97yPr8sEeDc0ivb9yiXZ6dMd0TYT5lgL9mOBCBgEsEGtr7Wbr8jGjUy8h8PCrLZDbil
 v2qzFBadFPCtmrSXNZo5cvBCCcTZtZxhNzFTa0hXC/0bQ3PO6kZ8LR0k60YayX34m0me
 T94EwEjDMwdZ4Kgzvzp+qbZaPNw7rEf3o4T+HwDgM3YdvvuLroDxPqnN3djOLF2HzGoH
 H6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781877209; x=1782482009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ACdilqkn/GLisd3wqAO2X6VYonz1Hu8bOa4bCPW+Aek=;
 b=NbzXaYiVDhKp5u38ySfZmh1VdG8cLjfbIzf6cBWDpF+bXrtg/0t9nr3jSOGDHL4WKf
 oaoJ+nu66+922hFlkH6TYFZHL5VYnBqgU6VpdddRMrqs/LAbyZz32XOeXjMXxnHVFQxH
 n5SBcC1XDVsmO8ZyVzThMk+AUhzsJupDnMRGiP3O3hN4Y9s5402iTazv2SSjVamatp6t
 6qmnR9SPauwEsJupPb31Tvu16uH9yqB2mTkRZzvEVQ5Z557NPF2mkj3vxI4oc72QhvaW
 4nIpbddz4n0wehAY1Tf3pACahlLSTya8du3cmxrchVOGvmF//BN6op5OgFdUY2LD7c6g
 yh5A==
X-Gm-Message-State: AOJu0YxHrkYXfo64zvRagHPUTD+ZU4zkjzE75duAyjkHefpUcrrkycoD
 7I+ifqH6GJ68ao2BB8FvjKlEv8us4YsrhIgXWwP0Jg/5Rw2CpUIPEi23/nfvLRKh5axcOdn3CfQ
 DpTKFMJkVLDk3gtQcx1A7B1KxY4nEpBHarvfWg4/ASPbWaNE9JaHiCYhAxw==
X-Gm-Gg: AfdE7clMHoI0hjCUFgKo9oewJnsF6b0x34fzs5A7t/iGmkkGrXmwDtLFOUxcW3sNVpX
 WYHue4RBbZS1a4lbMjfp/c3bd1Qh6/HKP6gD17K81hxT99AqgVkgRx829F3pG6AAbndnRJWnEZm
 uq5mrvv7h3QPIBnp9Lfdeijf+lF3m+nGiQzJrRdGPBk7mOcIkOBy/QTih7GlWGU6L7uQtkDflKG
 Jxn8sDaNQmVOTyp1+lTNq4kOocmiInVGHhA1EXs0/zOmH+iePKhSsXU45cDf+iA3Ap2HMjD44jq
 tsnk0RejvgYuVnBVEUFbN3ilhDYd/7KulC5VqENXdv+IdxDZFZWNaXbGYJg0Sa9mGvgCpruoZrO
 8Vzq5S3M7PZ+NIuNykAJYS98U7yfiLihPNI5+Mt1MchclnRuLca15WDN2o1mu4TvPwdAG3NlNFg
 ==
X-Received: by 2002:a05:7300:6da4:b0:304:ddc3:2c35 with SMTP id
 5a478bee46e88-30c0798b360mr2197232eec.10.1781877209389; 
 Fri, 19 Jun 2026 06:53:29 -0700 (PDT)
X-Received: by 2002:a05:7300:6da4:b0:304:ddc3:2c35 with SMTP id
 5a478bee46e88-30c0798b360mr2197210eec.10.1781877208751; 
 Fri, 19 Jun 2026 06:53:28 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06d563d7sm2031571eec.25.2026.06.19.06.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 06:53:27 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, alex.bennee@linaro.org
Subject: Re: [PATCH] tests/docker: tolerate chmod EPERM when unpacking hexagon
 toolchain
Date: Fri, 19 Jun 2026 06:53:26 -0700
Message-Id: <20260619135326.1248896-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260619043159.2174062-1-brian.cain@oss.qualcomm.com>
References: <20260619043159.2174062-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qCEM9fzKSZ43qA1P7ew3IAYR_vLJjYPt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEzMSBTYWx0ZWRfX+BRZu09atlBM
 38cKfMx1RZCR37WCQ4iAiNRLhnYbutAeWchYuY4JiixaIggJeglQMNMVOcgtKyIsss+kDriOYgj
 zE6ENVo2DZzRV/H5+YH793dRz7u8v5f3MbdnA3njX/ANujCQAtS41kSW/JdiNWdnMWaqss15IHy
 hw99zhJ0zZ+7w33tczY3eMI5sslwvERi54Ekw5rEvHQrvUGhHjTIyK1MuszGs/zk9hQHtquS3dn
 BxY6x+qxCYyQWbZv5gDX3ggxNXbrNGPM5wOprMHh8OZ0ei6/eA6W6N253pj8iz+Y1tErQ4u6hwB
 ibC6iB13Yo6ZhNdwNNoRUDWU9c+MoW4efYMHsKRYI4wC0Fs93dS4eWY9CmfyaBGYTtgGufNGT/w
 BAS2hkMbkUX3Bh+gY0S2rIkA9v3G7uhhPGQKWE3imt3SpOjENPXH0ePFWEB8zB+khfLqdynHv0A
 f+OYQaeRtr+HBR+lQLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEzMSBTYWx0ZWRfXxbv+RjzPWTQn
 XkdURNIhmp84GOQdMheA3d59WCXJgmL4wCbIn5M5zFK9RpmNSHYE/ae5k4YggHnpuz7OzD6SeNX
 XGWtxLin3nq68B2GaAPbnOljw2PwQ4A=
X-Proofpoint-GUID: qCEM9fzKSZ43qA1P7ew3IAYR_vLJjYPt
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a3549da cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=qC_FGOx9AAAA:8
 a=EUspDBNiAAAA:8 a=GgrzsgEwWwdyEWDGJ94A:9 a=PxkB5W3o20Ba91AHUih5:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190131
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 18 Jun 2026 21:31:59 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
...
> 
> Download the tarball to a file and ignore tar errors during extraction
> with --no-same-owner and --no-same-permissions.

tar's man page says --no-same-owner and --no-same-permissions are "default for
ordinary users". Isn't that the case for rootless podman?

> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/debian-hexagon-cross.docker | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> index 23e8bb2fb26..817c903246a 100644
> --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
> +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> @@ -49,7 +49,12 @@ ENV TOOLCHAIN_BASENAME=clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-lin
>  ENV TOOLCHAIN_URL=https://artifacts.codelinaro.org/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}_/${TOOLCHAIN_BASENAME}.tar.zst
>  ENV CCACHE_WRAPPERSDIR=/usr/libexec/ccache-wrappers
>  
> -RUN curl -#SL "$TOOLCHAIN_URL" | tar --zstd -xC "$TOOLCHAIN_INSTALL"
> +# Ignore tar's chmod/lchmod EPERM on the toolchain symlinks and directories,
> +# which rootless podman's overlay storage rejects (harmless mode metadata).
> +RUN curl -#SLo /tmp/toolchain.tar.zst "$TOOLCHAIN_URL" && \
> +    { tar --zstd --no-same-owner --no-same-permissions \
> +          -xf /tmp/toolchain.tar.zst -C "$TOOLCHAIN_INSTALL" || true; } && \
> +    rm -f /tmp/toolchain.tar.zst

Hmm, I think the "|| true" may mask some real failures. For example, if
the URL is invalid, curl would still exit with no error code, but the output
file would contain something like "errors" : [ { "status" : 404 } ]. Then,
tar would fail to unpack that but || true would mask it.

>  ENV PATH=$PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
>  ENV MAKE=/usr/bin/make
>  # As a final step configure the user (if env is defined)
> -- 
> 2.34.1
> 

