Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9292CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 17:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wacZB-0005Dl-Us; Fri, 19 Jun 2026 12:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wacZ5-0005AP-U8
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 12:59:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wacZ3-00086G-7s
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 12:59:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JD9FP71852679
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HwNEIA2cbeU7mRJtRIRuJ4Ski0E/xamvU7Rf3lapWVA=; b=DNUAZ0gVWvXvSnVu
 f5m4z9vvGzFK5G1ywlR+m6YyxqQ5UObdZJuDdpFdDYemGwYCfbQFGS6PnER5Z4X1
 iDPfRSBxmtBu7Xbi9qp0VkzVKbKYZLZxziBSuzYKvE2DZu99MrPWNqXsQQ7zT6vb
 9SICUhHm3s9yAgdKFlu7KQyJkM5QMmX6hlL1KKkekMvbIy4OXrRlUvI0OkxZA3la
 UlxdDJGlSGHrSyKuBnrzYzaUHV1t9H54H1+sekshRusdhyuyaNOItgomi0/rJ0w2
 KBFqcUw0KcpPTkG/9zdo9F0osjN4+GpT2G5r9KPeBRFYZwPfxh8jQOmuMIlShWrT
 4RUtfQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ew5qs8y9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:59:27 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1384427c3efso8141778c88.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781888366; x=1782493166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HwNEIA2cbeU7mRJtRIRuJ4Ski0E/xamvU7Rf3lapWVA=;
 b=BXgQxMgkgIceTZjZaGw6ITxJYCC+RBzmxlULV1gCDJY5mAl1dIGKVE8HsyZZJVf8Tk
 ZjcMrilgs3a2lkql9rX7I961adqAm++NMbC0Qzc1h8gx17ZKs3fMc/cZl/Woh4Ga9irX
 vOzqmw854iM3638PzrvV1ZARbXVCECKkW2JvHlu7yEBrd+RzcvFKeilCa+IY8luxmP89
 AE+Cw9yN7t/9y9y88XTjiZcF2HEvM6GD8cnB5y462CPk/QDkfg3Iz6BBuw864DQoRwzH
 TWv5amNc9XUyNXr/uxnP9aMVwxLL3BEdFWB14ZbCn9X5Z96Pk7IsseEz2ALkEsWA+QWn
 sv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781888366; x=1782493166;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HwNEIA2cbeU7mRJtRIRuJ4Ski0E/xamvU7Rf3lapWVA=;
 b=p+IINTcMNy4Vj/fYOoUWyoSokEIv1EIvwTwg7zDHZ+Moa6b/2YlC7WYvByiKFhOrTY
 395N/PEjluOOP1oqp1SS01vsxb4RuWUBybvA/4PQIk5PKz9AAEmBV4wJD6ns6bP+kYIp
 3RI9NJ16ZXLAoS1XGffyRLoDQ5snKCbZEL1oumKm3NRX3VR6J8kbmpbT2YqnR5wsqoHL
 1tthJ0tFMFiCe1da3s5vvAr7x2ysi8kWdbAXxgVdlmLj21mFJ+3l7ngOpRViBmOYjyTF
 vhKr2QN3Uv35uNxc78d9BSZiuLeR5zb3anuuohapUkNWFOUBHKYuqQjWdgLPxIyrdnU6
 4LmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tGoKH80fuiV0ZQTvX7AuP6VCI5d24P+wguP3mQo0R+A6pV1w85IHRVxtPcVzoknwZusJujSC8H8PZ@nongnu.org
X-Gm-Message-State: AOJu0Yx5FrR/nCdbY2aP/iwsirh0hFsFdd/bWHL0YJVMi/APqrultm2H
 wQo0NDjgAMywwIGKNZfa2Ceg8Mj9TunlZR4L3UYLmEp6S3J9+sLIsOzwuJW5tAHWArg497i43Yz
 4RQL1Rml6+8eZnTIwHw+BDIM/2dNiDplZ4YZJLAFXlyBohHK7E4oxcpq3NQ==
X-Gm-Gg: AfdE7cm0qWcs/DgIr657sqvpgOJp8kyNLpMmi0SiGaya4RCj+FfUX0/49D+zDThz4ni
 7JYrcjgD5cow8CSYn6H2PZWyzq9OC+P4+preQMnZBQkcEUdLaaP2kT+x+O9OamMJMipLj0PqRxy
 v2lqqo0s3j9iAufRGZSzS8or47VguT4XEN+QjnHKzZS/2XMaBiUzzGlt2hjBW4FbE/IEJ0zrcUY
 Flv+7FRptqg/I2GmFguVqYhpIZJOekxBv1bLglbk6ZbC0MbdZZUrCd/dKlGlgnVoxlkCasU9wFL
 9Ou5TbTx86zOpjMZC4ip+0PAM6hAkYd/Q4NkTrY2armZKV0u63LLZWz0iXL2lAtPcj7zwYHivIi
 9re7TP9DnsFX1JwEf5L/H4gpIicwTIyLa4HDnLRzKQ3YS3CiEJ79FQ4+XIDqIQ08+nrF3dw0odq
 7Srq4=
X-Received: by 2002:a05:7022:6ba5:b0:12a:6fb7:87e3 with SMTP id
 a92af1059eb24-139a505080cmr1526682c88.31.1781888366259; 
 Fri, 19 Jun 2026 09:59:26 -0700 (PDT)
X-Received: by 2002:a05:7022:6ba5:b0:12a:6fb7:87e3 with SMTP id
 a92af1059eb24-139a505080cmr1526666c88.31.1781888365749; 
 Fri, 19 Jun 2026 09:59:25 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139a34a266asm2080245c88.5.2026.06.19.09.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 09:59:25 -0700 (PDT)
Message-ID: <2e793fc8-b83e-4c42-93b2-aad833e39838@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 09:59:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] gitlab: remove build target hacks
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Cleber Rosa <crosa@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
References: <20260619155657.944220-1-alex.bennee@linaro.org>
 <20260619155657.944220-7-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260619155657.944220-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2MSBTYWx0ZWRfX+GmYpHeAaY9K
 TrVFFMxQSd5R9B7CZdXLKwmb3M+u1NqNiNQjhxrLIFCH4Gk1IP3jTjfLWJz06rDq4QeM+Ybb7yF
 h9AoIaQT4NjgxESDVAOIm6piDHcb/jv+akUKPtkKuddExyDPzVeTomy6Q0qTXAyVAtUHJHEOlyj
 eHJR65dw/xp04VKfNPBm1U33hBNiMnQvNYHE673Ddp40ADZtTxeLpzz+2/JvA+4vecASJnbbu0z
 ZGTM2Ef95rhOTwoKJ0tTQIciCns6N3ppOaVAIjis9woKoRTUXUy82T2QBFIUuc3RqeOuZ0EePF2
 eI7cBdECKXlPa8uCao/O5HBLohZUsPzQ/BqYWwFwYv+Qyqa1G+En3cxg4EkjcahYH/pNWwjz56I
 1mPYFsBhIwysFvyCGAkRcbLsob1MXvxYl76AbSsZrpTXRBttYWX7IG/JefdTwl3DtipU4p0w+S/
 tC69wKqKX97loHQVJCg==
X-Authority-Analysis: v=2.4 cv=M9R97Sws c=1 sm=1 tr=0 ts=6a35756f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=rg4mmxDJhifrDXa0jkoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 7AsKk1k-ZnSuimaWiRFeopKj-kTYl7Ii
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2MSBTYWx0ZWRfXykkhv91IseBS
 8aENjbQ416xQ0rBxrjprPvBlZRcwkYA3eNnTyW6dWvITsxMdTqWV+tqFMqQBBGxlU7hKNAJ1K+a
 pUQ5vsfC5fkf967wNL2rrEWdl371bhk=
X-Proofpoint-GUID: 7AsKk1k-ZnSuimaWiRFeopKj-kTYl7Ii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190161
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

On 6/19/2026 8:56 AM, Alex Bennée wrote:
> Since eef29e060dc (meson: build macOS signed binary as part of the
> default target) we should be able to do a plain build and everything
> just work.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.d/macos.yml | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

