Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0358C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1sXC-0003YS-Ke; Wed, 02 Sep 2026 17:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1sXB-0003YC-8u
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:30:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1sX9-0005Dk-Oa
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:30:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KH3AZ2685553
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 21:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z7oFRj1R6F4mIelNSYnaioZf5DMBbVaiVjpdUne2Zs4=; b=K9iz9LgMBtN5tjJK
 C2KjEE+05ZSuBRgA5qUwPElXqlidM5F+iMLyOV0OKXn0k88+cpoZyZfeQlELddG7
 ED9AgbKhMuaG2Txdz6HLDRoABZ+zSolIbVKWCGI1YX7UAaJLxuSBGEUdmMMKLa82
 HMMbP7puiDIdB1gs4nTbHdbRmcgFCUS48MpshTTmS0POS/MPmlCLZqVLNIqark7G
 LOcL3lVl2THnYssSD6WoVkJcnfEVdiTHRos63rEvI7bvO10y59XTVr1Qf6+XiLjM
 KHWhWHlQBNYg7nPQVtsUEnUxaBF3iFSOZIk/47ljPULHR1m7gNH9i0EiCnNa8wDX
 lpEjeg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv8akgr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:30:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936e393061dso239737785a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 14:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788384612; x=1788989412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z7oFRj1R6F4mIelNSYnaioZf5DMBbVaiVjpdUne2Zs4=;
 b=fpowSMAJghO87tOBz+4CLm1OAHBIUomIWsGFQYSTu0PjXhLMjHt4K+LyI02Xlins3Q
 +e6zdDvlCqL6AlHHSxavgKtPz3IfebJObL+RtasuRFoPaPIs78pHzNjXbPvWhHdGzMPq
 3tE0T9BtGfhF8COSN7rMI4cxvAamCscXv/9sU5ijiPzj8hhfuODm5CNXdPq4tsFLhuHq
 aw2pKeT/axl+sKLMyg2+Sybg6M429mwJUIYJOMlohHyhAmJoTHOZMRp2KSrfFaYw3TQH
 n6PKMC2UBzdeCcnFmv+yViD/SvK3VJFUrdHtZqN/7zFBuCwECEBrLu/IwJcmTYDy8JuI
 sgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788384612; x=1788989412;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z7oFRj1R6F4mIelNSYnaioZf5DMBbVaiVjpdUne2Zs4=;
 b=qdoHW3QHY6ncD9iSj77/8FDBFFalRuO2+YNo93YVDADbFkvqf+fzpO52j8AIX2z8sH
 MrWGZy0gkh3H2tLCpUWN2AAY8V/rtJjOaAWnORzQ7O2+m/peEFuLQKHK4HiLj/zogTqz
 b9P2olqu/wKXTLRXJTXHZ8KBlii1JFNykfxJkhuJzTVWA/VkX73zOUT8Y/a/3r6JlC9d
 4mhWYP1d9GRxCVvCQzSn62pGi727a1tkO1NwwJga1mIFisYyoTyy/vR6QB2eS4ZNDTA1
 KmabossD4CTMQuFvONLYDaCLrqS9aYJHPHUWXJcVfoY4Bn3sOfk4DA7NxoYEkaY9RweT
 MW8A==
X-Forwarded-Encrypted: i=1;
 AKwUvByG/Eyw898NvpjL8Uxv6nLv+uIBf6QiLkbK6JYi2isoDrs90xXtTgCE2YEGtsdrbIVuXZX2y6bb96AN@nongnu.org
X-Gm-Message-State: AFuF++lMnFscEzvV9ymj4vpq5eV9QBDpOrNA311mO4JX6Iy56tWJjhkD
 /zBYLrHzZCdxHSLwY/v0VBswckkhiQ1JOkQn/TnDC6LOXQFpqXxLAQrNpMJBG6Wza4fIH9I4/5a
 YkucGQctGtKTY6Emv30t8c8kusDHS4v/NMzL3L8zM952KPtvcdCsgA/pMGg==
X-Gm-Gg: AYBFou08aikgwBzpOjxvt7gflTAF1foTJJEKWYGps3BQrJu7L9ZGNwLP1E/1ZwVEEWt
 XOyza1c6/uDIm9yNDrcZmW2RDcQg9QCzsU6ZPTkl6Mb6c21EldtLCZDUgyfexzMBSkqn+6e1GMS
 XgX+oy22pznelbiLP3m6HnyExHaaPthHagrQQwJ6RZW02zcUH3K/3U8a2GFyFI2Oowq+H4vU4Mo
 Qexl+fY3ARtsRDLhZBDbGp+VJlOp/uG2K4CvrAsMKF4DJzAKQ9uVGS8TJ8DcEZifguDj7AMcc3u
 mwMadGpMOgfx83W11lgzB37JQQ2OnAzG3ok0TXKkkZERUY7Sw6Bxd0n4y7fh+mHtHjMKWfi1SMX
 1/m4+jsubHFSADVNkgpfLcGZkdKKjMxV/qQ==
X-Received: by 2002:a05:620a:536f:b0:936:bc78:791b with SMTP id
 af79cd13be357-93960e22003mr750836085a.15.1788384612405; 
 Wed, 02 Sep 2026 14:30:12 -0700 (PDT)
X-Received: by 2002:a05:620a:536f:b0:936:bc78:791b with SMTP id
 af79cd13be357-93960e22003mr750827285a.15.1788384611782; 
 Wed, 02 Sep 2026 14:30:11 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee80eda4sm18108115e9.15.2026.09.02.14.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 14:30:09 -0700 (PDT)
Message-ID: <c3f2f4e2-79e9-4b3f-8bae-88c669a34c0b@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 23:30:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] hw/intc: clear pending bit on l2vic de-assertion
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Sid Manning <sidneym@quicinc.com>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
 <20260901173353.200474-4-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901173353.200474-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wPSjAmfGGHbxHf5kyCDK_2do5y32Z86z
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a989565 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=CDaaqbpuOxbtrJYFCQUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE5MCBTYWx0ZWRfX3UEDSh5mEKyp
 nvArbJfT3mFN9akyj+N2bNhcu7ePuIFBUjJ9Mf1Hgp5TFYaI5fu5zMVXJDm/gqTdDRzSYbn6nR1
 8P8m2IpBuZDbfd9CLfZD//LPLOV7q3NeD8umwPfTM8V+6am2vix/Raegs1E2J1Aw+99qhBdgb/I
 A2HlHkYL0tBYiLLTtvoF/LYJxYoM0pNMOIhZdsfN5rinaLjxlHtl305exbF9eTqKUwP6/Hqm54Q
 ps+4bl8lOgWX6wnKroiJtUG1L5CoaPGRax9cSvzfn8u3StOn3yAQjrmM/M1EY4lQoj1OYaDbPzd
 oaRenQUjLEW+o6uyFf3mnZa7B+EiNOhWUQAHGNXEyqV4JwgDuEVYH4mxq8YotbLxH62+PNoM9Y2
 lNGLDEX4m/IsbkHxOLm6rlczThfW8UnQg73Zmdc12lG5W77wqfD+sdrILyv2j554zE7QftX0d0E
 lhHuzexe9m6IvbeFXdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE5MCBTYWx0ZWRfX9DYhIFYPo35i
 iXoGYq0pFRjVQwxNvVMJfgcVRo1C3pWzw4fK9lAhAH5vsE96RcOjXCRbydK2ROxjfIfHKvnVgyb
 b6bOapSq/uwr18AUiaqtln1+WHN7xWg=
X-Proofpoint-ORIG-GUID: wPSjAmfGGHbxHf5kyCDK_2do5y32Z86z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020190
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 1/9/26 19:33, Brian Cain wrote:
> From: Sid Manning <sidneym@quicinc.com>
> 
> l2vic_set_irq() clears a level-triggered source's pending bit on
> de-assertion, so a source that drops before it is latched into
> int_status is not spuriously re-delivered on the next ciad.
> Edge-triggered sources (int_type set) keep the pulse semantics they
> already have via SOFT_INT/set_irq(level=1).
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   hw/intc/hex-l2vic.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/intc/hex-l2vic.c b/hw/intc/hex-l2vic.c
> index f07ec850d49..a986f0bdf35 100644
> --- a/hw/intc/hex-l2vic.c
> +++ b/hw/intc/hex-l2vic.c
> @@ -299,6 +299,8 @@ static void l2vic_set_irq(void *opaque, int irq, int level)
>   
>       if (level) {
>           set_bit32(irq, s->int_pending);
> +    } else if (!test_bit32(irq, s->int_type)) {
> +        clear_bit32(irq, s->int_pending);
>       }
>       l2vic_update(s, irq);

I'm confused with l2vic_update() logic which seems to
duplicate a bit.

>   }

hw/intc/hex-l2vic.c-95-    /* Edge or Level interrupt */
hw/intc/hex-l2vic.c:96:    DECLARE_BITMAP32(int_type, L2VIC_INTERRUPT_MAX);

Not obvious, so 0:edge and 1:level. Ah no...

hw/intc/hex-l2vic.c-268-         * Only auto-disable for edge-triggered 
interrupts (type=1).

So 1:edge and 0:level?

Tiny helpers can help to make the code more readable:

static bool edge_triggered_irq(HexL2VICState *s, int irq)
{
     return test_bit32(irq, s->int_type) == 1;
}

