Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DEEC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 19:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdv1N-0003sD-Qm; Sun, 28 Jun 2026 15:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wdv1M-0003ry-Ni
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 15:18:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wdv1K-0000Rk-S2
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 15:18:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SHj8lG449452
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 19:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sj6D2FXnyG9ijPWn0FGNucx7N6YSejIA9naP4Md4qiQ=; b=eczg3r4qmgJPsNBd
 xvT6MDleV56Ww6PxQXEaCh8wUPlL6GV64LZd+Q3GQM+/8ycT0bQ3KNCuYI2VIDOt
 R4+2BL6jmjOJ64v1iSwwD14AaxrNAQr/FvpFzhYHOs61L7rnZDbYCMSx8GZuHo2z
 yWGmSlq/g9qpiDvIvgrpCddUsJrxx6Ga2L8crKDGA2JTZ34A8BATyneeSHcSryQF
 CZ9ZXBd5kk0MIyZx3/rnDZ6e+3LhiggHsIZotsVwBU6WWWTJR8I2yL9G08pDPGdB
 VBFgFUrdrVVjXgz4lDOx9HJAG30aNeWu8eV/ljJMJb8nTAnwleKHZYRCLltmfwJ2
 olxC+A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tukejq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 19:18:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92aea0d801dso372639285a.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782674299; x=1783279099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sj6D2FXnyG9ijPWn0FGNucx7N6YSejIA9naP4Md4qiQ=;
 b=aHu//eZGdoGxzfZIfK+7Z/ta8ybkyG8biw/XO1E5C2kWKmWXv7NYQgn6kvQBg+OCyt
 eAzIw9lneKmRuVwOcyvyPXGm/A5WoVWdTydpsDTlPOqmp4rm8sZucwJizpL8kBb9ndnZ
 iMG+V8l0PdbT3RB6uDo+/wWtTDa2fdJUPwxFVzFwYhTNIsgEvZAPuNLoHrWFfQK5bfnA
 OassCvvKTiudhxv91ir/h8R38phPfgkMkdTXK/B5vmac6xaVD/COJi9aGDQYU2YZ1569
 KBPb1G25Bd1xYSqOMn7GmcYNx8HfuAstE1HUuxr1Z0pSaaa0rMun0uNIc922Jj5YPxot
 xmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782674299; x=1783279099;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sj6D2FXnyG9ijPWn0FGNucx7N6YSejIA9naP4Md4qiQ=;
 b=sfAfxcGDKrZ6FCK4TN/S3C2RYz9qZBpP0Wsq2AV+4G+ADi/SS2OOcUfIZ/qCYIH8Cy
 WSaoXjDGMVfVDl1v0VwChvmL+5Jdg3Ko0zJL5cAJm+5p4Fa5JaapqhfTpEqli7Y17AiG
 28HfaBdgmHVeoi/jiaIVKBKHLBzhjRiUCeoRUkOvcQPc/of8mH9LN1FowsNvOKHmcT2T
 TPlqICqIgG4a6z6wTSaCcclUZ+3sUbnxH+xrZz6TU3gTr6plmZUb8IzKRXb2mgMrgYpk
 +9wugAbnsLCVnJTU64vrlgF3ASLSOhAS/lEA5uUhwJXJKM+X4ple2pK8FVfN4bscz5gp
 5jig==
X-Gm-Message-State: AOJu0YzPS9mkKBzuUj8kWPRxnETjxxxVQlbrcPPUB+x1AH4Ou80kcWTy
 oKfBszGgCbxcFbH6qco23K8L3aazJux5C0eA+WIEa5PZZW5YToeN8NePelh0MMKxfBsTqBYYm5O
 VNL9ExJUD8VCe6tYVy2xSPG/+RIQvE7GerRPVk5YIlYGnvRFrAnt/aS6QSK8RYWivtQ==
X-Gm-Gg: AfdE7ckR5M5wym+xlcakeh6BrWiFFlnyGU7nE6uZaUBI028x6pvENQTGi6juaIp/FrL
 ZHg79SGialY1dYLNlv8s3HLzutA8sw5IHQdi82Eyllk/1U8s7Iyf5C2AXqBewxcZ6dQeDGqx8OP
 e1RKsOPH5G1QlgoL0o0PLKtroNeP97YcjIHo4SfbiIX3K4x8dlQLjPtcoh4ULbcrRmn2FINETNq
 xQh1wNTuO+wMzx1OqV4JEeXpTB1TDi2sXoMMYwR9YUd/iSO++nU8YZsjV9zlpkC3ATqnLs99lOo
 GemtQluXLoQmlqlO5kXaGpI9iQsUCgBZ2MrEZpsnBoeGaEH7NLwxwyMiN3+K3tL7xlVJASIyDRF
 DEvbYbKG/xSERhPCKraH+Tj57evtaO08k60E3HcV3Lk1ahXh8KGZwbXfsYa48A3SonWV3bqOm4D
 GPvuUg97spMA5b9X8=
X-Received: by 2002:a05:620a:a0c7:20b0:92b:6805:919d with SMTP id
 af79cd13be357-92b68059c04mr779879285a.69.1782674299272; 
 Sun, 28 Jun 2026 12:18:19 -0700 (PDT)
X-Received: by 2002:a05:620a:a0c7:20b0:92b:6805:919d with SMTP id
 af79cd13be357-92b68059c04mr779877885a.69.1782674298677; 
 Sun, 28 Jun 2026 12:18:18 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fd391075sm1839302085a.4.2026.06.28.12.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 12:18:18 -0700 (PDT)
Message-ID: <78cee8b3-5fbe-432f-bb6d-0b2800630c2d@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 14:18:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs/meson: disable hexagon idef-parser for emscripten
 builds
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 pierrick.bouvier@oss.qualcomm.com, stefanha@redhat.com
References: <20260628190358.634435-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260628190358.634435-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OGk0mglxOULOsGDVGfOPaEwhLkn1nNFo
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a41737c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=q6_yctSJp4-BavkxsiYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: OGk0mglxOULOsGDVGfOPaEwhLkn1nNFo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE3MyBTYWx0ZWRfX82y8e4/9Cke3
 wTMyMvbLs33Reji9M5Xm9deJYORDty880vZlcCMz8+i15UkyU6Faj5f1vEjEmwm2K9oX5sglhlZ
 HEDkQRonpXLKUh71zL0SlE424bW1zeXAc2NwYo1pLcqauCFHuKg4aZrd9Afg3Qo2w/cz9/43nlC
 hmKufkt+XLFLMynoXXlOMcvnMmmgydAOPEMeB/fMEgdPBHpBg/1xfvsIpVw1SXum7qqAvjy6evX
 wwY50g1RA988jO7qvv2IdXdKhkYCxClmbUj4Rf2LbkXFDgmMiY2LTaiF4KDro//annQJn2vXcS4
 +61KgKvVohKfqVWkWsnpAcWxcCkKpp1Bty4YtJ2nd9GFayPwKUgfpivFE0l0jXABeuT8T0dEhQA
 KB5EAmwWOVOMhVY61Z8tdO8b9iSlT3YmQs4KAq0QaU9KOkCbWjhvd7mKUc07HYdla+z/AMOHRrL
 J7fqeYqxm1q12vB5UiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE3MyBTYWx0ZWRfXzm8GIQVtXwAa
 Dia0Rt604Mntg2/dq2ABa7UWRY3oKYzneMjqhbhmO0GSmXiwoPcrBqVS9J4Hnm6wcLsP0eJYuFw
 Lm/6x+1OOrBtZGyKn4rSr2kUpx3HKIA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280173
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 6/28/2026 2:03 PM, Brian Cain wrote:
> The idef-parser is a native build tool that requires glib-2.0 on the
> build machine. In emscripten cross builds, emconfigure sets
> PKG_CONFIG_LIBDIR to emscripten's sysroot which prevents native
> pkg-config from finding system-installed packages. Disable idef-parser
> by default for emscripten since the wasm target does not need it.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   configs/meson/emscripten.txt | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/configs/meson/emscripten.txt b/configs/meson/emscripten.txt
> index 4230e88005f..c5c57e392a9 100644
> --- a/configs/meson/emscripten.txt
> +++ b/configs/meson/emscripten.txt
> @@ -6,3 +6,6 @@ objc_args = ['-pthread']
>   # configuration so explicitly add the flag here.
>   c_link_args = ['-pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','-sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','-sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']
>   cpp_link_args = ['-pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','-sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','-sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']
> +
> +[project options]
> +hexagon_idef_parser = false


I also considered a change to `configure` to workaround the 
PKG_CONFIG_LIBDIR override (below) but I didn't like the idea of such a 
broad change.

So this one has narrow impact to just turn off the idef parser for 
hexagon for now and we can revisit if later if desired.


+    if test -n "$PKG_CONFIG_LIBDIR"; then
+      native_pc_path=$(env -u PKG_CONFIG_PATH -u PKG_CONFIG_LIBDIR \
+        pkg-config --variable pc_path pkg-config 2>/dev/null)
+      if test -n "$native_pc_path"; then
+        native_pc_meson=$(echo "$native_pc_path" | \
+          sed "s|^|['|; s|:|', '|g; s|$|']|")
+        echo "" >> $native
+        echo "[built-in options]" >> $native
+        echo "pkg_config_path = $native_pc_meson" >> $native
+      fi
+    fi



