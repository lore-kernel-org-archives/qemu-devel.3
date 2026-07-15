Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CABC44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 01:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjoFm-0007GS-JS; Tue, 14 Jul 2026 21:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjoFk-0007GI-KW
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 21:17:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjoFi-00015m-I1
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 21:17:36 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F0I8Id1817185
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 01:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L2ewfvhI9DgFjfvvXLrxBTx4aJ2lpCQ1LioLw+O+H6s=; b=iNZuIpRGHBNgSrfj
 +E1Y2p7sQr1lwZoIJeSvJ6YZwllLTJsao8xSHw4WC9TdEdgsBmN5m89naJ3yusxq
 iQrS8wAxt2Yll27x3RpKrdmzavDvK6e5gJdl2BJggBEGrTXKFHAeSRloxyo9W7/N
 DPsAt/0hCmOxwxCjb61eapM7vA399ew4E63praaB/0Kn+mFSwER1Ab5EOe+jfTVj
 A5ZaUNJoKMY8cGQSAXYKE6/efCLxDqb5jfCXjFMaBYppMN3AGvh9uDlYeuIMTu82
 uu6sdML7Lib83Cya42x/kjcasfgBJOUmq0KfekG2YV+uOVcLBaeozQiIAd32y3rG
 2+Zggg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9mhct8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 01:17:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-380b630c505so5987989a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784078251; x=1784683051; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L2ewfvhI9DgFjfvvXLrxBTx4aJ2lpCQ1LioLw+O+H6s=;
 b=MwPVi+RBnCP6lWBcVaQRQzxfqfwgpQEL1XhvDjyFT1XQ35urSLJjAAvrNn7gzQBbrL
 Gi54ujnedAk3/wjn4WjI1EL8GKtIhpPc0Qe7up99sVCrJuz0pbwKQP9gnj1ZIwze78ly
 2272EPWcj9fxR4Kq85CZNkyrgO9VQricPAmyYEZVDrq1uoEpS3Ccaq5OTN4NYVU+86lw
 NoXxGdCil3p5VDXwNSH1TLZZyjIusQfnUoFlpjrCaU4aZs7dQVEbtdvua28NU5VdhEIo
 hwjlv7q+2z5T6WF4jtx7R/tiBt8n99E31QaJPlG9Dk4mIhYhc0s7uWovyhOhpaRzhcDN
 vH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784078251; x=1784683051;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L2ewfvhI9DgFjfvvXLrxBTx4aJ2lpCQ1LioLw+O+H6s=;
 b=Hfo0y1DktvNvXcIg0LBsqqdJjtQcUayFSD+TlW1qkc7RDLIbwKJ02AA6GQjr1yuurR
 yPLmRng8R8dI5rilpVmm4fZ3a1jPemLCt8sCnlF13fSsr9UJipnkdgtyTGMIGtkHKblk
 X4LQOt8UnLugP45taBi+ETpubbXCFHz5yfOHmLZRuK7cLR4CFoOfScXdeGnmv2u+6D55
 LsS4znKnnex35wqdeDMhwuPAG6jonhKjTxxmgn6NqhbG1857QC/44a3J2YBFMOols4Qd
 AuFo25MyGa1Ma145M59kDhI0sDwjCKktjQNQLvrTh8WCloJB8hNEZjD3GGBX0tHUecx8
 QPew==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbWrXopTU7jfVXV6erflC2NyEMoIP+bqyH9MHBLIqFocqhhmIWS0laR9nc5++/A7mv45jWhh30HZWr@nongnu.org
X-Gm-Message-State: AOJu0YzBipYKlHo+/9YI04vrq5+ufwSD/ZL2F3vb65iVphwx/DGUAIwZ
 RHBldo4Mc9JKzpiS9+PDejIsIdTN6aO6yQJyqwwWABnH/qmYoT1pFAsyTIISWOkx6qXU6p/z1Fr
 F9fLe4PRSOveG8e/1q/F2c9KCzq64yF3ggjkDfgoTZBIYVcqWnPh5TG+6Wg==
X-Gm-Gg: AfdE7ckbG2ert4GAHNZdmYnIcQOznpTNdshTbjcoZgMOCYqndLArmRzYFbpZDsmUNbZ
 A+nmaDVdGdq9J43HWhp+2GQ6Jg+/ickGUoTBX1LCZ893K5aveR+d1ZLgjlMgoVTHMydefuuMndO
 95UWJ+GIX8HZHK8wP9Vf9TmycZUJeBEZCoiU0hfXAZz1HQba9ytoY4MlAcqwhDhkTVep3JpjnKo
 o2I2aNSDyY/EV2lMR+exfxVtWbxbA9QmnfwwB3NGwSL6h5Blv9PwqDAZAwiNf1xMF7IgO2UHiRG
 tlO6B1c7VYr5YvyJ9jrMSRRKgLPK56YnDD/6efJZczdOTP7wW4S/hIaLzbuVfunEFChcUarB3H0
 suSPM7MWLV3KihVCK4Jstp4TtLGQjw8wOPVkyqvtcpqgC29iLRooOl1I+6gx2HjrbAx0dotnFlz
 Yc+hY=
X-Received: by 2002:a17:90b:3b8b:b0:38d:dbc7:5179 with SMTP id
 98e67ed59e1d1-38e1af35e87mr4256026a91.30.1784078251084; 
 Tue, 14 Jul 2026 18:17:31 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8b:b0:38d:dbc7:5179 with SMTP id
 98e67ed59e1d1-38e1af35e87mr4255995a91.30.1784078250513; 
 Tue, 14 Jul 2026 18:17:30 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313f3ea883asm11997707eec.29.2026.07.14.18.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 18:17:29 -0700 (PDT)
Message-ID: <32acc813-37ae-4708-a842-7d7958b7d388@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 18:17:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] bitops.h: Add find_first_bit32()
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 philmd@oss.qualcomm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
References: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
 <20260714155126.3509544-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714155126.3509544-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAwOCBTYWx0ZWRfXywHKN2bWujFm
 +aeVa1VtaLSR5S6TTQcLorbSle1q8a76JuXnfFBleIC02ozDZOmEfhiSEaLzpJOi3xGHAmaZYvv
 GZd0Ia3j0tqBhKcz/qtWw4ob/o16qXL5MQWV3bDrqbfbg0JSbE5f/+2xcR8lJWGuYIT+pbTndFB
 cJ9j3otYCE5ENPFNhumxChLsBdqUHKd9xPlfPDHBMPxUC8NFXVrvyCwobNcYAI3szrlar9eu9N1
 87BzZxmgQyX2ZjmGmkkm4Gsl6pHIJx6R01WDC+HLv0Snm1JAC8g+5dfx3t1PsOMdmLepZgdkkbO
 bbf/yjbebkmkfrt97gx/2gz1L9v2I/E+r6to6VQTC+oMrl0seP94r4isRluZS/QnaWGZw8eqV52
 kkkwCqXxOKpoRJ/Gxgze694zVS0/PuJulDnqmY7h5gXH9KLHjdper0amEkI9s5yTRr2LvO+Ve6h
 xtN5iS+7538eYqY9jBg==
X-Proofpoint-ORIG-GUID: wfyJndBp2bpPWSx8VEMk8Q-m7DboIr9m
X-Proofpoint-GUID: wfyJndBp2bpPWSx8VEMk8Q-m7DboIr9m
X-Authority-Analysis: v=2.4 cv=E+79Y6dl c=1 sm=1 tr=0 ts=6a56dfab cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=4gF-BoOHGjt0etSkoMgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAwOCBTYWx0ZWRfX2XAsMrzYDQEO
 KJ0++LQDezotiaworOcx8K2QiIIfYruusse8GyyD+j9WdcOLEIcpDgRvg7EqMfJ8Uch5IJvym4L
 RTFLTaYXHKuUNdqbURjVxvEIQyWJsDg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_01,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150008
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

On 7/14/2026 8:51 AM, Brian Cain wrote:
> set_bit32()/test_bit32()/etc already let devices operate on
> guest-visible uint32_t register arrays without depending on the
> host's 'unsigned long' size. find_first_bit() has no such
> equivalent, which pushes callers towards casting a uint32_t array
> to 'unsigned long *'.
> 
> Add find_first_bit32(), implemented the same way as find_first_bit().
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/qemu/bitops.h | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index c7b838a6283..f7363a5479f 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -43,10 +43,9 @@
>   * be some guest-visible register view of the bit array.
>   *
>   * We do not currently implement uint32_t versions of find_last_bit(),
> - * find_next_bit(), find_next_zero_bit(), find_first_bit() or
> - * find_first_zero_bit(), because we haven't yet needed them. If you
> - * need them you should implement them similarly to the 'unsigned long'
> - * versions.
> + * find_next_bit(), find_next_zero_bit() or find_first_zero_bit(),
> + * because we haven't yet needed them. If you need them you should
> + * implement them similarly to the 'unsigned long' versions.
>   *
>   * You can declare a bitmap to be used with these functions via the
>   * DECLARE_BITMAP and DECLARE_BITMAP32 macros in bitmap.h.
> @@ -382,6 +381,29 @@ static inline int test_bit32(long nr, const uint32_t *addr)
>      return 1U & (addr[BIT32_WORD(nr)] >> (nr & 31));
>  }
>  
> +/**
> + * find_first_bit32 - find the first set bit in a memory region
> + * @addr: The address to start the search at
> + * @size: The maximum size to search
> + *
> + * Returns the bit number of the first set bit,
> + * or @size if there is no set bit in the bitmap.
> + */
> +static inline uint32_t find_first_bit32(const uint32_t *addr, uint32_t size)
> +{
> +    uint32_t result;
> +
> +    for (result = 0; result < size; result += 32) {
> +        uint32_t tmp = *addr++;
> +        if (tmp) {
> +            result += ctz32(tmp);
> +            return result < size ? result : size;
> +        }
> +    }
> +    /* Not found */
> +    return size;
> +}

Either we should express size in terms of number of elements, or add an
explicit check if size is not a multiple of 32.

> +
>  /**
>   * DOC: Miscellaneous bit operations on single values
>   *


