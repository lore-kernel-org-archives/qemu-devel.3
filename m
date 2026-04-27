Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17341FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOet-00063V-KS; Mon, 27 Apr 2026 12:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHOem-00061o-7m
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:18:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHOej-0003AP-UP
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:17:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RDkDuO665665
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 16:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a9PcAVtS6aiAY+5oBEIuwWBp3d9cmqxfThizqaUHFWI=; b=Gjv5WnjZpEvvVK9k
 sFOfdT06pk/mwguk9KxDuDXHny8PeusQxWcpCDMJ6Ufl4IMDTgil4XhKaZDQ8Eh+
 GzdFXj5xxY9+B0X4AJ+AeZcx/rGrjhFs4GVVGqJUah7tOepru5GLOpPXQdy46VfP
 PPcuJymns29p+5IlnP/bSb/Q2f3owHZrMhc6wZzw16zeLD8xUMg8gY8Z0fVQmqYr
 f3tFIymyTIWAGWOv8RWuX9AB+mSX+TFG7CG5I1ul37OENvPFYfmpXHWullDptFyG
 TLxZjXge2nUmWr2ZcoefZmswsK0n7Z9JHn9KPZQf/5wpkRGizWvdmo1bOqqwsGTR
 DgIGGg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt30n284e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 16:17:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2d9da2559aeso29018450eec.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777306674; x=1777911474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a9PcAVtS6aiAY+5oBEIuwWBp3d9cmqxfThizqaUHFWI=;
 b=VnV+6RaA1E2sk5ylTt2L4z4d3IGggrotuz5dHgQSRa0ALfb2SXTG0wB5kgihOpQwCe
 nrj2hhJcP6qNQ1hJnjeUgLJmAdhFENYw/JMr0PHQsD+PpN4IRPBunl2YT6Yt0nyx0YDn
 m6zziF5m1DE3NID3rkW00rCmw/50kc4ii0/ypbzmQKRw6lFRpdfMV6yjsGtY1xg+I/Wk
 RJPoo8jwGdPkQQaoEyvZrlxG4QLzLi078Thix3DJ4WHP0Qp9M9yOyCHzLmlqM/tDoGs0
 af/YW3f1YDsRnYKwsWo/zyw+F8BseVJxdYQYgGlgNe6Kr91yAJBcfGvlDnsbAb8UfQQB
 5/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777306674; x=1777911474;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a9PcAVtS6aiAY+5oBEIuwWBp3d9cmqxfThizqaUHFWI=;
 b=kelG/Tw86wZXp3W4Dvn+dFU5ryM0hhb/55TdRs4g4yWycfIEldifjpRpaOg+ZKwk+u
 yEITkpIJJEK2wdkt2wcAKwBkRcgfiPF6oK9aleI52p8B4YxSxe0GaAnUhi13tSH9iUHZ
 BTulm17G2gzkRZaB/VMbCzVnYLLi8zKqCUe7YXviOyF2dDlrcvxJA2kQrI50HDj11meX
 IsjS0oGSI57bNx2ebjJ/JZlZyXGtc8LvrvxfPjGztQpSGLqGHk6WotTqqHIdD0TRXByh
 aj1e9g/U1lhyS5CXtWTVrqXYP69IS9XwBoX5VSVqRDTZtuWF4ARm/iDbU3Je0c2FH39t
 dMmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9q1e7dvblr4V4OY2Y/Fy0W6RAlGlDkALRXePR19Yej7lijS2zZNMaGZYxl7ggkAlkxpYLPcK+fUYy6@nongnu.org
X-Gm-Message-State: AOJu0YxJ4B6i+Yzjwpc89bKWT/39bttmJRHl5QU6GiwirNMMzTXg1BDP
 vebuLCSw3wIEjw897OzGMVS8P/4RVA7yDlq4MMIqb2zxhSGfUuAyVWZNHVrfkwYfpq3IK9pa849
 f4tVIGICdBRA6tWj2qrPVdc75kbnqXxlVyR05pmji9GHBYxdTGPAZxeWs4w==
X-Gm-Gg: AeBDietkuuvGZ4j/hdGs2eo1MLiUiQmAdUzDDg1eVUEvtDQ9/xC2MimcyYzz8iiR7no
 DhusovGh8OKGtCnBfGpAoPSXoskzg2+zeslRiYJz19sGWN0/3jYsismN181bZ9n8YbUAKj94ecY
 nFOfRo2RlxlT51LmRAjsgvIwAcZ1QzaNrSGohJ+AOsnjY0l5tVakPvdfLzyiHz810ogShOs2q8G
 DkMdhwOxFK59lRCyU7/FKsHkdOLmtFzTEqLxAShqgwog6Fl7qKYLl7NL5vgHQ0BudsLUdzfLNdd
 AjNDCkOB5xjtJ5nWlEUJO8q0h7RT2h6ouVS+llvAEY+96QLLTatvnHe4WC4KLafS7XQ1WyU3Pss
 V8SiUUOytnlqsG8pi1d4f4ClCYLtuBRIMgwnzNJ40TivoEWKlmB1G7D5SNKkoJ+JQpFTfmJ6Rni
 /vrTROYhxsVn4C4VAAbUWg+Kj6
X-Received: by 2002:a05:7300:f193:b0:2da:1874:f39c with SMTP id
 5a478bee46e88-2e4657728eamr23400704eec.12.1777306674085; 
 Mon, 27 Apr 2026 09:17:54 -0700 (PDT)
X-Received: by 2002:a05:7300:f193:b0:2da:1874:f39c with SMTP id
 5a478bee46e88-2e4657728eamr23400675eec.12.1777306673505; 
 Mon, 27 Apr 2026 09:17:53 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53ccd2564sm44901550eec.18.2026.04.27.09.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 09:17:52 -0700 (PDT)
Message-ID: <6f68014b-e3b5-41e7-9474-b2964661d19e@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 09:17:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Document TIMEOUT_MULTIPLIER for raising test
 timeouts
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260427161132.1463385-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260427161132.1463385-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE3MyBTYWx0ZWRfXziEncVrlMCs/
 Izfr6wBxCYaSYBKJHRTwCVYDVmXkowIyeaK87Y+GQ9w+25ObU3e89lRjifY2RXnd3OdBpQnlDue
 jk2IO4SFz34why6s1KKaZ2rN7Z/yuXCgpG7f/1l39WdGG3wko/lr9N5MTORKO+TeE7LJwKZkJet
 7vm8JsIK6diVPW+UwlbMyEsTN/sY0Y4tIzl0ZWvZKCk+nBZMbqMZVmBKoZFyG1+PbgUtxGiD1+X
 FhzLBEQQExCbXxWIfjWmceO8733oL6TP5m8zrgAKk604T7YzJBuNFK3AuQ9h8aF+45KE3toMGL5
 BIdLXW9G5D1ck4e2i6acs8fxuiait17FSabnDBPcZmSDNWd2NSVI+q8t9MSK5fFUoBSlll2MTQg
 bq2jTJWwkGSUP6BTPHv/x1HRm1BzyVBEDoG2x0g0HZfjea/YX6mhxgMjqOzIkD0RICVLSshxqtp
 PsBOpeqqONAFM6WUeqw==
X-Proofpoint-GUID: Yw2I9nE0wp-kI9SrntsdseAQdqJ-nHDo
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=69ef8c32 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=vZyKO-s3KdCvBMF30bkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Yw2I9nE0wp-kI9SrntsdseAQdqJ-nHDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270173
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

On 4/27/2026 9:11 AM, Peter Maydell wrote:
> Our test infrastructure allows you to set the TIMEOUT_MULTIPLIER
> environment variable to raise the test timeouts if you're building
> for a slow environment.  (scripts/mtest2make.py reads it and sets the
> meson test -t argument accordingly.)
> 
> Document this so it's not a secret feature only known to a select
> few.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/devel/testing/main.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

