Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F226C624CD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0w4M-0001dv-Vx; Mon, 31 Aug 2026 03:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0w4L-0001WW-CE
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:04:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0w4J-00022B-JV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:04:37 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52NfF3678670
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iIgpAqEOQ4S16YbCIXTX7pg1TUANpIT4iV5g2lk0elA=; b=h+8zcRmYjsCv9/p+
 aiVkd8on1NDdkXuer/LYSWs2404H8jqLrcxtcXvum2XeTBHZHtVULWZzSjFFUg9D
 lW6BWXyNOXhLEhEzROgFeTeYCaJHhAw9NxAT6810oNcWlXIpR9aNhlXpkp+15O89
 p2A0JzKstF0+29wymEB/jkZBGXNd5wM8XKaQbqGdO6zQKwKy5wEPayRdN7GqGWGC
 jr7EALwL/EzSU7FvDHP6vZRUv/9lnOPupQSgQiZh9dTp/QUh/9pBWERTmcaqMGKS
 fYtdJsvFUKKiBUaohDSzLbS+Eiz67WnCzHTrZ2Q8Bq5X/M1kKL6Djc2HG/kpVoUW
 rGT6EQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv8h1bvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:04:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9390ca1a9abso456199685a.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 00:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788159872; x=1788764672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iIgpAqEOQ4S16YbCIXTX7pg1TUANpIT4iV5g2lk0elA=;
 b=edTsJGxROzkFqVk+MSie/e3iQXo+eOSjgHHiXHLzHtMOhK4nMDRUuVAZj9qGZ9hzy8
 mnX5EzKlSpo2+e0Th8QaejArB/yNJDaX+TQGC+zc6YlBs6zxNdQo/qUxNfPWJU1s4B+B
 nX9TpiAprHMGqdSaOCyN9Ak6hI4bytrim+31xtzrfG/0iK6Aj8yn9NDBN6kJqRrOyHEd
 NC88AD2d+xjH8zKU9GdFoCZAC8DdzY60RCQbdu6/mh1XKUKFh2pCCu4ez9IeQ/uoJs8W
 CoBJcnbpssGzRHgovIrV9vg7bqrIuwsuyARVrFSdfcosm5pMTWLQJ8wm5kTXQNQN1k+3
 eSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788159872; x=1788764672;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iIgpAqEOQ4S16YbCIXTX7pg1TUANpIT4iV5g2lk0elA=;
 b=CS+yoHnkfXtNCbm1Lu9IkYeU71U4+cgI0djg3ddSlVOSBwj7iHAz8pheUXCHHhVTbX
 OemedoXl3s+5EY9yV1w20NG3NOrTYzJFdexdRzpjEXnuBebSlZnQJDvWYcIs5bPNB0JQ
 ACXd369l1fIt8o+P9MLN1JxamurGVfyuP/FJv2xxDaD7o8v+M6rjGq9BzdPbOM9p/uHq
 OSsjEQifP0SIFPuuGKx3IQhiVTpIQ2kk9S/JqoyENqOlbjoj0TwVkFkQkdn4srOtErad
 zy5IhRpjJBnuET6dbjewVPj8hH9ju5cIqXRTNeEk9OU4K5rZDJcrFdY7Rmub/B5UFh9h
 JT/g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqfu2/0HVBdy1k8ecp2+0DgfgT5K778Bn357gHT+7eEtj0QrO07kWRob1RRlaU58jEfQYkbP3GSqWD5@nongnu.org
X-Gm-Message-State: AFuF++na16Oxrb/0Vm//+6g6ErcLOOwoeHU3fkWPzuoaRyisQCDDRJiV
 jvJWwYu+wyiDpnGMCb6UUM6MdTSSnlz5NNhtF8DB+PbTyFZdy0sVgDFYSi8TMdPRF2Oy09m/Wnh
 eJQo6Py6y1Og47voqnFG5SKyZqEOtQr2nuBT3rKBPF18qBOWQoPC2afqdLQ==
X-Gm-Gg: AR+sD12Ja0XFKE9IR3PbVsIiJIq+x0fVlJSNEjbBRAVZj1zgOzPSpbTHgLwsBMi4PYw
 d6lWFm3mJyIjhRQlR0R08JGiT5VZThSLgH6Jeznv4Po0bDjWhnK9q8tLVO6dRctMcsvASjct/jg
 w7EVQni3eXk+Ms5HlLReVf5MthLvxIKzw3SAX5EKhLdgw4+wBs85HhOGLRMZZW4b8MQnTIyeeLE
 NYuk65z3bWZ4P/cUjpNmb9RPWostT5pJ9htKJqazWcv2WIaXbEz+WEfDFOLy35egrQWAyWLv0Ys
 /gmufDPjmw4cY3kskr5qp3SXQiGTXg/Y3JduXAZpfbNabkTcWUGuiW1bBPhuj8vJu30fmGsl9BN
 fjJtNn/icZF7pL/SY4Fx+mlD9Nk1ftndMqw==
X-Received: by 2002:a05:620a:27c3:b0:939:e62:bf0c with SMTP id
 af79cd13be357-939137af559mr2944470885a.4.1788159872243; 
 Mon, 31 Aug 2026 00:04:32 -0700 (PDT)
X-Received: by 2002:a05:620a:27c3:b0:939:e62:bf0c with SMTP id
 af79cd13be357-939137af559mr2944466885a.4.1788159871844; 
 Mon, 31 Aug 2026 00:04:31 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48432022ab8sm13842037f8f.28.2026.08.31.00.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 00:04:31 -0700 (PDT)
Message-ID: <38a48f49-d045-4287-9164-5692f4f9598e@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 09:04:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/47] target-info: add target_config_dpcd
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-29-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-29-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DY0nbPtW c=1 sm=1 tr=0 ts=6a952781 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=EQbr7gpKO-z8JmJY6SsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfXyo7kEUaebaxi
 1v6TRnXP2d9htHeMx6P8q8CZpvoWMMeK3DKQ+sNtxJp7niAmkflVwu6xz2GSBDX8DgVcdnqMlUm
 qdN7/3jjymFGtYPPqNEqeKnCT7xbxlsKxOJYLuTW70reOgiClVH+5J+IGKFG48dF16BUPrSe26g
 646awml4jh6jIcDusCyyjnP9r52bxULzxpes4V2R5MEQP8QkWWrDw7lYAFYHos596qNv8cmQcmw
 iaJcOUb7M8Xej+T67I2diVWy8loAOkTKxvpp8nq8rag6PyckzbpY6BFfFlOEf9te8ItglBB0q9E
 FdPnLJJI9M9NtWXNzbRYgaY3TXBQ/+7VD3E3bpKMGFfm2uQCQAiYEfuA8PFXnOv82Q0cVujcBzZ
 bFcuTHFYsYSLj5XHSSWoP3MJscJ/OyobCnGroLHBj5SYVdIkuLkzRskhAlmsI9QZHIiPY62kVtF
 vguSXkd+TaesNGZB4rQ==
X-Proofpoint-ORIG-GUID: SEIgAM4WNjEBkGf_VZoiq_1smbF8CkY4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX3PvMfhOJ0rrm
 SSWzPtm3l2Kf75U16X47zv30QjfFCg+Ux5SHP6E4R46sZEDoAwGtbhAv6lhvGhBO7GPCkRGlDSp
 j+gdURBl9OvEHLTwL3a6OnimmV1mo7M=
X-Proofpoint-GUID: SEIgAM4WNjEBkGf_VZoiq_1smbF8CkY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 29/8/26 00:58, Pierrick Bouvier wrote:

No commit description explaining why we need this change.

Guessing, XLNX_ZYNQMP_ARM is AARCH64 specific and is the single
Kconfig selecting DPCD:

   $ qemu-system-aarch64 -device help|fgrep -i dpcd
   name "dpcd", bus aux-bus

We want to keep '-device help' output unchanged, thus we add a
TargetInfo dpcd field. This however doesn't sound right to handle
a target device config in a distinct way.

IIUC the DPCD device is plugged on a AUX bus, but the wiring is
done explicitly calling aux_map_slave(), meaning so far devices
can not be plugged from the command line interface (maybe they
could, but the code required to do that is not in the repository).
IOW we shouldn't allow TYPE_AUX_BUS children to be user creatable:

-- >8 --
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 877f3456062..240447598ad 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -317,6 +317,7 @@ static void aux_slave_class_init(ObjectClass *klass, 
const void *data)

      set_bit(DEVICE_CATEGORY_MISC, k->categories);
      k->bus_type = TYPE_AUX_BUS;
+    k->user_creatable = false; /* Must be wired calling aux_map_slave() */
  }

---

My suggestion is to simply add a previous hunk as a patch before your
"single-binary: command line reference" patch in this series (can send
if you want), and not add the TargetInfo::config_dpcd field at all.

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info-impl.h | 2 ++
>   include/qemu/target-info.h      | 7 +++++++
>   target-info-def.c               | 3 +++
>   target-info.c                   | 5 +++++
>   4 files changed, 17 insertions(+)
> 
> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
> index 4f6c898c707..045799a771a 100644
> --- a/include/qemu/target-info-impl.h
> +++ b/include/qemu/target-info-impl.h
> @@ -31,6 +31,8 @@ typedef struct TargetInfo {
>       /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
>       bool page_bits_vary;
>   
> +    /* CONFIG_DPCD */
> +    bool config_dpcd;
>       /* CONFIG_MULTIPROCESS */
>       bool config_multiprocess;
>       /* CONFIG_NITRO */
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index d775c94d1e3..a60751a4ef6 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -42,6 +42,13 @@ const char *target_cpu_type(void);
>    */
>   bool target_big_endian(void);
>   
> +/**
> + * target_config_dpcd:
> + *
> + * Returns true if target defines CONFIG_DPCD.
> + */
> +bool target_config_dpcd(void);


