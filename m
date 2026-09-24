Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDA4C982FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 04:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9bCB-0005ZA-1y; Thu, 24 Sep 2026 00:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9bC7-0005Yt-VG
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 00:36:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9bC6-0006KY-2R
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 00:36:27 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O36kwY445905
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 04:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 401Ehn69pZR5WU+a8Ow41kpser1p0tewRluDaixMfWA=; b=kAAXDdZeygUNJQsz
 3z+jzGs2XFaVbiGRCpcsypcQdkDLkzyeVxGzdpaFsJ5mvV5RL/Hi/FSwYpwWc1xo
 CJnpDgMb3ZACTBTkP3x2zbhrF8c7Li8JZ+jwTyvPMNLEafzC73Y7GkCRccwiYLwP
 F6G7oq/5yX/kGsVY4yOBcXzZ7zR/iM9kMoGNFXcD1/30f0LNqIkiaAapRGtjXVZr
 dZC54on0kXpDCIFXHITOsHT6FGx0wiJJFFMG0dAnAhqdE4D6bFludWbr2zIn85zb
 N9RCfEUCG4svX77SG+khe52/XSbOLdSjjmN6tXY1ohopx06gLBjYXsm7xA6/iQso
 ZcGDdA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvr908xgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 04:36:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93903622880so98233685a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 21:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790224582; x=1790829382; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=401Ehn69pZR5WU+a8Ow41kpser1p0tewRluDaixMfWA=;
 b=LLNyOa9lURe6reejnlH3GJSZu4okMsA170e2rRNL07gVPRp0xCeK4ouHpmBCGDarfy
 aUAorufYzZANjBFaIvxz5JNwZeJsV8Drozll78c4cJH5YWSuNZowkXa3wRCzrC/WIWiE
 /ceAaEolv3Kl1ytmLsJ1xIXDPIdgXIv6hfhawnZQ9phYenlYeiWs/lZTpCrwX7V7Rlk/
 cJhH+uNU8OFgrwAQFotM8ptapdpRR7XKI7qKUBeYbAIVaWc2D+5wEVppnw4KuwpML7z7
 kzJn471AsPgx1s1yZiL7y7ZK/juoxujz4+mb/sTnk3eP2BJuRqDkOFiyPvxbAlLFyKwd
 wXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790224582; x=1790829382;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=401Ehn69pZR5WU+a8Ow41kpser1p0tewRluDaixMfWA=;
 b=IFZBDFbL7FOzxXo8g5yso+HyAZ6vQGNsXsx3WGUFU7Zpd8Hc11HcD4cGv3+T/5diHc
 vjT2Wkfac+edcTjG9MG0+UdFH9tps4DWn+OPd1qwmkVUEtPpt7X8BJ5kCsTGrA1/bPtp
 oNuHCnq6zqiKsUBQ+GFpM5GwyxCnXhg9kU8G44Ie+TUdkBRwmIyYiW4B7SCKJQpqMuB9
 C60gia/uXMUcYck5huzhj9ZALm+b7XPgKIBsDF01uesk3BwKCRIMX9/RNVM+3THWB3eR
 l4N9CT6GMU2MHxemQ+6dvohGahwIHQCs0Rx54tkywTro+jNd4sVB4X1aX74oqwk64t6Q
 /VZw==
X-Gm-Message-State: AFuF++ltQeqBLNMyMJJ7NX1xa22LyMX8BtlWVfN7hVJpdkHFzTQ7MXj/
 RELIjON5d6GE/jCXhBEoDfdLmPo0ou4De3Eq+7RuAuYnD6KwHcpBbM73ZweK+DcFU3bgA0H+BgM
 aR+ADrAzYY17ZbWfItLtAoMCHmL3OWCO+qQ6OwV4beiPFVECw5w/GPvEVVA==
X-Gm-Gg: AYBFou1I87x+sHD6QiFxgB82uTsNeYS8gIT7pHqlPu7P5/AL4BvI/wYieod9HXYt0uT
 ba6QZ88aerfHV9asKPK/X5NbTttXdS8CcuH5HUFtMfMOLtV8GNeucpQCKW96D17MfISFZ+rdc/A
 rR0GHzbbb6Cc2M5S9ICD+h/ewzE43SQlz+iZfFhxsxw4f25bFCvI17scpgnlhGXilddbnGRB2i0
 yqv7VsAwj9RmVN87v7VBMGdnsN5Xn3td12VkUAW48KKUVKsCkIqf6LVrevKAilWJ404xuODH1o3
 Kdl32DnUwxavpUCoVL0zLtF+lDY7kT/xfTl12XveN2vXL0s+rrxTewuHqd6OoOicLpZxoQYno7G
 dn44hOiczMTszCkduTtmHIKexhubi2hxtfw==
X-Received: by 2002:a05:620a:271d:b0:939:a095:e458 with SMTP id
 af79cd13be357-93c3661d870mr104901685a.3.1790224581833; 
 Wed, 23 Sep 2026 21:36:21 -0700 (PDT)
X-Received: by 2002:a05:620a:271d:b0:939:a095:e458 with SMTP id
 af79cd13be357-93c3661d870mr104899185a.3.1790224581333; 
 Wed, 23 Sep 2026 21:36:21 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5bb9891sm32407085e9.6.2026.09.23.21.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 21:36:20 -0700 (PDT)
Message-ID: <3d89eb19-ced1-4bdb-9f2a-fa6eddecce49@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 06:36:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/kvm: coalesced mmio: check lenght of the MMIO write
 entry
To: Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Cc: qemu-devel@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>
References: <20260923164631.306314-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260923164631.306314-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyMCBTYWx0ZWRfX4oQnj6asqMyU
 QP1GiM03yXY0A2G94t+mHKEQrnZf1w69vcNTYLozBLmf4wCw0IsjK+Is/N50g9GC8xtal8W6mLN
 CYNwJTjEjBMZm4lp6ljF5zNrbIxCl8I=
X-Proofpoint-GUID: _csAALqMpnvR0tik-7SwqKDCzl2AR-JA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyMCBTYWx0ZWRfX3quWPTY6xtaq
 HGEf7cnQgtvhLV2YJE+u0cLTlSGrkT3YWicphy/kcaIw6I+/CMsCKNbOLuFetgUvaxLR5QWBM6N
 ynnsZ3CWPGZ6/ai0y/xdWE73NA8HJINFQQT+4ennNV8+uiSJdfibJJgVTeUNISBzXDOPEVst3HI
 ZeRMkccul78KvWwf3cSyOTaZQW4C6y+3/SOUah5ciyNH3yGA4cyCFdUt/5Tj03TyFlK5x5OeH9K
 Eyu+YK0FmINvz4IP4J3dOelhig18EmH4eN3Kto3UkoFEf1TdMi8++CgPzUktG9LBiMpKX5+e35l
 Ue24O5TAM34GBto4OKiFRnZ0k5jLmXstcOuxWXKQ0/e9UI/+ViEks3K2g98rdlHj6pneRiEPumw
 Fu8y2SPX6UEnjXTn5J6z6WilvJr9T7Cgn9VgmWNBlilecU8+z5xD9Kj8t3+6om2R0UtyEiWmvA3
 d0bQz8qn9QX3lPU7TAA==
X-Proofpoint-ORIG-GUID: _csAALqMpnvR0tik-7SwqKDCzl2AR-JA
X-Authority-Analysis: v=2.4 cv=fMusTpae c=1 sm=1 tr=0 ts=6ab4a8c6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=_M0NCwPjLKdnwxl479UA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240020
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

On 23/9/26 18:46, Paolo Bonzini wrote:
> Queued, thanks.  I changed the code to what Philippe suggested:
> 
>              ent = &ring->coalesced_mmio[ring->first];
>              if (ent->len > sizeof(ent->data)) {
>                  warn_report("coalesced MMIO entry has invalid len %u",
>                              ent->len);
>              } else {
>                  as = ent->pio == 1 ? &address_space_io : &address_space_memory;
>                  address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
>                                      ent->data, ent->len);
>              }
Thank you!

