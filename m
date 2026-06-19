Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB30CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 21:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wah2i-000563-9f; Fri, 19 Jun 2026 17:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wah2g-00055d-U7
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 17:46:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wah2e-0007gf-R7
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 17:46:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXeVO2932941
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 21:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cU3D1obbnsJSzp4DnULDvAoSRD9K9Y/cd5ObJiMIVt4=; b=CnltL0A3gubIaJkQ
 /xEEw65rcljWDRSbyDGsc2BNwNjcgwHLwZjb/KR6cYjFE0SKY2b7FWmcF+DS6ufA
 f4OgzC0jLfVO/I5354I6QOKXie5Xj79jVNPitGvddBoDALJfqANza5idmfAgh7Xw
 OTj3POlqXzUtBO01miUO5+ysvRSbR3v0qmYaU/AQ3p/mHzjJYSZTmIowz/l/07EK
 X57dSXzSAkr9xSHl24LbkFHQD5StM4gzlQz3k40OpWxyhjheHR+LRbZ9QxcpZa87
 5+wBkSlPMiSSRlr6zGqkx8u1Af0lkeePDlR0u5JmjJohzHtZsvDfk8BIiqTsZM5F
 AA7+hw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ew5qs9w9y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 21:46:21 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139553dd8acso9818189c88.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 14:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781905581; x=1782510381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cU3D1obbnsJSzp4DnULDvAoSRD9K9Y/cd5ObJiMIVt4=;
 b=FvqX26ysgN9pfBecWYEyyL8Eag5O9IEyBefj9KrXGpOivopVzCCK09rPA/U+GotnPU
 iumJL8ZW4f5Y2wmByVDL3Zb/XLh5szkj6GwWrOvohxumR0vA/mI4gH/Yr/YhrGpKfSax
 k9vNbwYD7xntwR/JQ+RWfEfyy60kUlsyHobcOBMHz1GQwnkxk9op6fbn4gLUzDq4xlFa
 PafIDO37S0eo7LmZjfGPfTgzmKP+6TQ5ukjxFKpJalZv+l6eSfG3lpwmoFkjR9WF8I2C
 RmApPDjgxYZO6LkCVIPG/p2++5bej7T4/21l40YqtD8DfNBT6t81Wu9AVGdSwNi+gdOy
 jqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781905581; x=1782510381;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cU3D1obbnsJSzp4DnULDvAoSRD9K9Y/cd5ObJiMIVt4=;
 b=jPaYVAnizXAuaOaOjGFkbrDY49Vk7LeWR7QY9xJ6CQrDJiCkhgQXlkWsgHdNKxTUrk
 x3dvVlVwwZsxcl5Va7321Mygzp8TwG5/7JnTuGaJYCo2iAoJ3DtMg2rc71NHbXYCFu43
 Psu5yIO224g2jl4k6VByjvv9RUD1yOrCCCc81A1htQuyGNazbdFFs3OAwDWnSGGkv9Vg
 LVetNqlrMfB+lQhBrgw1kL9lBWgMg7FOGS1CjteTTl/l0QgrRIk1s6VQKkIuuipx/xUD
 MoC2Jx9UFELbsGZC3PVYkr6d77VETWKo4Cqi/0je5owlWHwCVSU6zPMnoGf+6+SphFZQ
 bK/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zcR8uEJLwoUYXNMTMkypWLfs8ddOxc6lnsaWkbmnfyBRu2qEByrZ15hdKTErsJznwYa1/JmvRDE8U@nongnu.org
X-Gm-Message-State: AOJu0Yxldh6zQrNUf4PbBTOlSiZR6bm1jTzJxWTY6Kl44tnRf72+P8rK
 I7T+eUZR1BbJekF+2wzkPY0nqH8imZgkhDjZOt5ViABVWyOfBo5nqY9IrW/7FvZ8sYWyPdQRGS2
 r47/PEuXWjYZLTdIkau5WbgsUF88jjkW75ZddgLMmYmrZ+8xwB1LW5AWdkbNNGa3qCQ==
X-Gm-Gg: AfdE7ckvh6HmdtBGqQQlVqm08tYhIjWdfPtMpSqSNcLAfIdEraBb3Iy2iqbZ9DZlg7I
 IrhQj/IsFinpRQqZuxWvyBJXP7AoJ3mfbLPwia92RCRNTSf1dbtJI0RNe/o9IIvORiglZvlghQ7
 Q2eJcDSkivBaV3tcktPsV76pILggIYMiQaPBejQ6KsgG5NdmloUGTKWC038qbJGpppw9PT9vzyc
 bWfZZo7hXSMuEveACk4TvAfALGYdY67gyGMdensIw1c4p9Df4Z086whwzxNOMgTQYTxriu6zNSQ
 OlPsko5TTkX3WsZ+PaIrPfARf3f8P5Trg3GPY/sZGb5v25aLPahz7Zer4zzQhZm093bixGegQV0
 5dzpILGk3nvy/FtDDkTG1KfjP0euwmxtmpxje4xJzLtTSfb6Rjyl64+4Umunm9p2xFOmhcWxe/E
 kH00k=
X-Received: by 2002:a05:7022:2201:b0:137:ed4b:c9b4 with SMTP id
 a92af1059eb24-139a3686b4dmr2740555c88.28.1781905580576; 
 Fri, 19 Jun 2026 14:46:20 -0700 (PDT)
X-Received: by 2002:a05:7022:2201:b0:137:ed4b:c9b4 with SMTP id
 a92af1059eb24-139a3686b4dmr2740537c88.28.1781905579982; 
 Fri, 19 Jun 2026 14:46:19 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139adca1b18sm542078c88.3.2026.06.19.14.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 14:46:19 -0700 (PDT)
Message-ID: <dd9efa6a-2824-4cfa-a4b6-4b0201b76aff@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 14:46:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/docker: tolerate chmod EPERM when unpacking
 hexagon toolchain
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 matheus.bernardino@oss.qualcomm.com
References: <20260619211142.4126199-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260619211142.4126199-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIwOSBTYWx0ZWRfX4FVd+ic/g99g
 Xgr+eVWrNwkcmZ7/OymtttoK7otJQhv+j+mM2all7A43c8nvfnbGwuLE4LJZHw6X/LZk1nyAqV7
 HHMGivi/JWthFNjXsj+8plA2hK2DYb+ErOp6Vc8/LypzHHBHnrC/E7KOGlukMqkiYz9RU0Ixcem
 O3GndVz7iNWK3Ln82zvf9bJgTCzYNn3jU2xrhr79dR/MsSlYJXq/i1b2prk8Bq+AXRE/sHlYTEo
 a2w678WRyfg2LlH5wkhtmBNVoFt5ug25HMJvxhyJrkCR2UOhAhMNwKTDMlZT8MtvHFYCyNVFU82
 ntghh7DvCKXpHuEsVTpV/eWoUiHcePhFWREk/i3SmGeMtEKEUMLfkwh1rPeQP/3oYMQrR3hKM0T
 KPvNE3Q7ciAVsi0lHrqus+kAtvBbrqHeVGOGI30yesRQ9xOSEMHEexT7TvwrUYiBE+WR2jG9Joe
 AFHcvtVSciguzNQMRXA==
X-Authority-Analysis: v=2.4 cv=M9R97Sws c=1 sm=1 tr=0 ts=6a35b8ad cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=5Pc6o7UY1IG8TtlQ0ZUA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-ORIG-GUID: BjaidjrgsvLuKp6DheipN_wZNdgG93cg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIwOSBTYWx0ZWRfX+7GqrSqKIBc7
 kIbFfiJu6Qp5VPoHRqSr/hsgVd94rT2jUodNX47wqo/dReXQp4WiNLzYe6i4E5q45KNUQKXNPHA
 nQau7byIRKfT8sPGS42LNwHxnwGUoAM=
X-Proofpoint-GUID: BjaidjrgsvLuKp6DheipN_wZNdgG93cg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190209
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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

On 6/19/2026 2:11 PM, Brian Cain wrote:
> The debian-hexagon-cross image unpacks the codelinaro clang+llvm hexagon
> toolchain tarball into /opt. The archive contains symlinks (the .so/.a
> library aliases) and directories whose stored modes GNU tar restores via
> chmod()/lchmod(). Under docker, where the build runs as real root, those
> calls succeed. Under rootless podman the build runs in a user namespace
> on overlay storage, which rejects the chmod()/lchmod() calls with EPERM:
> 
>   tar: .../libclang_rt.builtins.a: Cannot change mode to rwxrwxrwx: \
>        Operation not permitted
>   tar: .../x86_64-linux-gnu: Cannot change mode to rwxr-xr-x: \
>        Operation not permitted
>   tar: Exiting with failure status due to previous errors
> 
> tar then exits non-zero and aborts the build. The mode metadata on these
> symlinks and directories is irrelevant for our use, and neither
> --no-same-permissions nor extracting as a non-root user stops GNU tar
> 1.35 from attempting the lchmod on the symlinks.
> 
> Download the tarball to a file and ignore tar's exit status during
> extraction with --no-same-owner and --no-same-permissions. Rather than
> trying to distinguish that known-benign failure from a genuinely broken
> download or extraction by pattern-matching tar's stderr text (fragile
> across tar versions and locales), verify the toolchain actually works by
> running hexagon-clang --version afterwards, and pass curl --fail so a
> failed download surfaces immediately instead of writing an error page
> into the tarball.
>

With those options, I don't think there is any reason for tar to fail.
Also, as Matheus mentions, it can cover some other issues (disk full,
process killed). So it would be better to remove || true.
You can leave the hexagon-clang check anyway.

> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/debian-hexagon-cross.docker | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> index 23e8bb2fb26..fc1e3ef4e37 100644
> --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
> +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> @@ -49,7 +49,16 @@ ENV TOOLCHAIN_BASENAME=clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-lin
>  ENV TOOLCHAIN_URL=https://artifacts.codelinaro.org/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}_/${TOOLCHAIN_BASENAME}.tar.zst
>  ENV CCACHE_WRAPPERSDIR=/usr/libexec/ccache-wrappers
>  
> -RUN curl -#SL "$TOOLCHAIN_URL" | tar --zstd -xC "$TOOLCHAIN_INSTALL"
> +# Rootless podman's overlay storage rejects the chmod()/lchmod() calls GNU
> +# tar makes while restoring the toolchain symlinks' and directories' stored
> +# modes, with EPERM (the mode metadata itself is harmless and unused here).
> +# Ignore tar's exit status, but verify the toolchain actually extracted and
> +# runs, so a genuinely broken download or extraction still fails the build.
> +RUN curl --fail -#SLo /tmp/toolchain.tar.zst "$TOOLCHAIN_URL" && \
> +    { tar --zstd --no-same-owner --no-same-permissions \
> +          -xf /tmp/toolchain.tar.zst -C "$TOOLCHAIN_INSTALL" || true; } && \
> +    rm -f /tmp/toolchain.tar.zst && \
> +    "$TOOLCHAIN_INSTALL/$TOOLCHAIN_BASENAME/x86_64-linux-gnu/bin/hexagon-clang" --version
>  ENV PATH=$PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
>  ENV MAKE=/usr/bin/make
>  # As a final step configure the user (if env is defined)


