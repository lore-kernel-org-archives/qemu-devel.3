Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40663C55ABA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrN3B-0006rP-De; Tue, 04 Aug 2026 17:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wrN39-0006rD-Nc
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 17:51:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wrN37-0000A4-Va
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 17:51:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674JlHTY1192579
 for <qemu-devel@nongnu.org>; Tue, 4 Aug 2026 21:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8odS/rFOb+GHnBfjk6L5xV6cdx9XGhVh9abu+2t5ihE=; b=ppU9ECuluHgNIPjP
 WC9ezdrW9y1nMCHdmEfKQ1op3BCO1uUzyNTXZ3gDjS6Knn6p80htfRzqbSwNM5/5
 VNRBY1yOeA/JOAq9J1SNPZT2XtAVNMQUgRrOFjQ7i0WJezhC3DqIRbUhbE4ubTVk
 RzbSO9vtDuK0DVv7EP3an0ngE2KwPWOhFcvotvKKAZZxBFwoLXPen0xXyZNFTP7T
 JU+DnWeJqb0XqEkjaKNiji0MFfvJjELPEuXkB02Go59YeSYR5sSQv2Rw5OzFefAu
 RwVMUdBdTZsajkC2qm70WBxZFXhkUZIebKzDVxmn+9cUlc4ROR0fLNhFbfUrR1tt
 iUFV4A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuku31as9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 21:51:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-caf5fa127d4so400705a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 14:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785880305; x=1786485105; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8odS/rFOb+GHnBfjk6L5xV6cdx9XGhVh9abu+2t5ihE=;
 b=hvLTg+mBcClK7A0+ljFWuWoOIiTqXe08+OuL3n+Aq8uo+VpHxeJ8d8FG6dSCrKtaxN
 TTnvwBmMQKlO7vItjn1Z4fPegTvmRRXR+jcgprWNIqE5t1Mw4jFRO/QxtATx8EHKnEJs
 4Q9PPHqW4ozyuYgyxxDqfuhiK/vrCdxENo3W2EGVONwU9RdZ3WC7WXgW436MaCAuMJ10
 KAj2wtQBET3BgqqWwYlVWDnCqPFZK9zBj/wz9/Lf5tYktCpApxI+JdH2RVlu1FPTqVvB
 qeLqCnxZd7X/S2BRQ8DM54Re5WQIqwuHl/2+2/mE63RIcUF0BYPIfzkesxh5EIY2LNXL
 AAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785880305; x=1786485105;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8odS/rFOb+GHnBfjk6L5xV6cdx9XGhVh9abu+2t5ihE=;
 b=Z5eL41ivZ3+MiW2s3OhPpat4Vwzay0Yqpzsh+OwL4kd1YdQkX6UXyVgoTS1c23+iVl
 Y8PckZ+u8+KEMLYnVZSYUVkroOgh+kTEKALrlOQJ3zi96ItjJico888pIT3Xj5EEl2FY
 jeZjWWEIJ0U8du/pEsZW4hDpvqhu+p7m59HCWCC/d9jOTcqHALJ+6/T34qPdNCjWsU8W
 VSz8bNqTEnZqkckIn9WMHGGOpjFWh7g3T8uwR8ZeyDUi6C+eUk2ox+MUG2UXVPTvFQYy
 lHg5Xs3aEJi0UVJWQkl8aIjXoDuFHKJ2JvMGHalF6AoGNiK/2NTa6q80NZp3Z4M274wB
 uW4w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDXyIgFQM4nsvdwemoTDhH5307LYEdTUVYmWAVudqTKVSkpoGU37WK9nTnvUCjwhiHflgv4ceXdOX7@nongnu.org
X-Gm-Message-State: AOJu0YyPocCyg8ht9s6KrZhAYnTrAyIw0oW83dWIpPPnyNxA2wqLbWG8
 mVgxOKrK0GpjJX75G71Zx1iiSd3rSLWSS6M3tfPbP2yjxe1QrVD4sBurEP0JdSWO3/aM/bcn2y+
 lBKfnFKfsYJNUAIqC7Mb/80QDtWd0C7mGE65v+Fl+0Lrhou+nP1oU/GsTUQ==
X-Gm-Gg: AR+sD13hRkyRa0CaNDyk/rP0LHTVbxAKONZwSayATPoAHonVzEp84rszzfx5ISPQ+Ct
 belkXV9zD3FIWIlNLgS1QMV1QmHvdUx968TZOTOeHI0wYB0Ks79Bp8wm+t2z2rDpfol8cRDAQyx
 bbePO4rc8Ibge/fdxTH5FGkiyUfa0CJr1ukvcjIguwL5QQJwT2Y1+IhKBxFEJDm9CcCAIOj4ahC
 xov0FttjGEH1n5tkZ4bTlkDLc2WOfbjCjlbQxkd7KOkdEGH0+5ZEYCA6Hyu31ZnUGjIX3+pncVs
 jSWQauNbF2uo19wOfEbP+aUBnqVcK5VMeTmoM043z9N8K/zkGqGoZsQp2rQrTNWSQT9XFkO2s2N
 7KPf6Pdn5tRsgPnVjK5jEPpUdDbHdPAOwV1JGMedTZFDfit68mKbYnxRVTqC/nuEypQ2j
X-Received: by 2002:a05:6a20:7fa8:b0:3c3:75ff:95b6 with SMTP id
 adf61e73a8af0-3cb85f50503mr1395120637.31.1785880304950; 
 Tue, 04 Aug 2026 14:51:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:7fa8:b0:3c3:75ff:95b6 with SMTP id
 adf61e73a8af0-3cb85f50503mr1395096637.31.1785880304507; 
 Tue, 04 Aug 2026 14:51:44 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586401507sm7948174eec.9.2026.08.04.14.51.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 14:51:44 -0700 (PDT)
Message-ID: <a90fcc49-9176-47ce-abc0-c682f01430b9@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 14:51:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: use stable URLs for zlib tarballs
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260803180700.367388-1-stefanha@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260803180700.367388-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -pBBllaJujXJPM1L4MfrwcBbltn6cKol
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfXwjbMmkEnblki
 FFtunoYZpnFd+ISPx/LkteEcO6i6oXZHXJTgS3DRVIlkmdWvAfKLjTVkDAl9Fan0l6gix1qLqtE
 R47MWSXXSZHrM6Ax2OLK6WtvmrwDEl4=
X-Proofpoint-ORIG-GUID: -pBBllaJujXJPM1L4MfrwcBbltn6cKol
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfXzJ+aGsW/cguf
 oDDAnMQ2mycigHkuE1iQvQHGKkpIxN4fcFWNzI1Jf1Q8y9tpewxaCYRU4l1Z1S2w+4sgqAtTPVA
 SYhd5pi9fjTqC6vEqU3VByJDN0DScpbXmhL/B0fQAhjiCsfESF67xgFdhcVGYXTeaxV4w20POEC
 1y1qqixolvBQqn4qslPazG69cM1K6NrTseVQm+GQEAk+ZoO9A2wagLT7g0yP9n+J5LYjx9eOrH1
 +hmjhg1PvaHtTHSAdLrLMSLRPXPNLdXW+eQAzPpfBNIZQHtmXt96tAHKlKAUFRl7Q33sm/qvey4
 AM85XAQe6QlWg2K/eNXZxbIi4AX7KDDAra4b0BK3d9lv1PkqjYF578LfpavtBBPPI/U3vq2aiAD
 R1m/V00XQa9pMCSVCGBK4Q0EDL/ewN+O1JMulel+naMtQFCfKs/jrug5bHy0MBbsmLFsJVMa2Am
 Tct4Pf7T95nBdiVrzSw==
X-Authority-Analysis: v=2.4 cv=X/hi7mTe c=1 sm=1 tr=0 ts=6a725ef1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=fXms6y0vAAAA:8 a=9qUTvQc-AAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=jMv2ikQTEZUydjqjLjkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=c6Zb8eaUoX5VaqycxFvw:22 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040177
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

On 8/3/2026 11:07 AM, Stefan Hajnoczi wrote:
> The tarballs at https://zlib.net/zlib-X.Y.Z.tar.xz become unavailable
> when a new release is made. This breaks the emsdk-wasm64-cross.docker
> file that fetches the tarball and builds zlib from source.
> 
> There is actually an archive available with a stable URL. Use that
> instead. This does require switching from xz to gzip since xz tarballs
> are not available in the archive.
> 
> The upshot is that the emsdk-wasm64-cross Docker image build will
> continue working into the future without causing CI breakage when the
> zlib project makes a new release.
> 
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
> - Fix "bzip2 to gzip since bzip2" typo. It should have been xz instead
>   of bzip2. [danpb]
> 
>  tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> index c04a741b0e5..4f26ce7a269 100644
> --- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> +++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> @@ -56,8 +56,8 @@ EOF
>  FROM build-base AS zlib-dev
>  ARG ZLIB_VERSION
>  RUN mkdir -p /zlib
> -RUN curl -Ls https://zlib.net/zlib-$ZLIB_VERSION.tar.xz | \
> -    tar xJC /zlib --strip-components=1
> +RUN curl -Ls https://zlib.net/fossils/zlib-$ZLIB_VERSION.tar.gz | \
> +    tar xzC /zlib --strip-components=1
>  WORKDIR /zlib
>  RUN emconfigure ./configure --prefix=$TARGET --static
>  RUN emmake make install -j$(nproc)

We could also switch to git clone with -single-branch -depth 1, but
current patch works fine.
Feel free to apply it directly to staging/your tree.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

