Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596DDC531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn01l-0001CT-Gp; Thu, 23 Jul 2026 16:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn01i-00016d-Tx
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 16:28:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn01g-0000hG-Ql
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 16:28:18 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NIlvbZ442920
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4byo7srvFsnOvA2OhEh2/Innf8ZLtBY7FDx3IcBnjxE=; b=bnVBvw6r2HOy/PMI
 goQrcXrHZSxqaYjg93pzwhVWL2WmymXJvcm3br8gvi+qEebscyyOsSURTHN1BTR6
 LZWJA7xTm80iJgcF88TQwEauj8rXwOA8p7RRp3HJNnVwma16/R+TFU/aIpwdhBgq
 oY1qWv7L/OtuaFJU+par9egPa4IBNy8C4Gk5eCm0T6nlJP/YjHMpUACX6keMSS3W
 Von+lSjFuiZHtwx3BiyWhbu7tXn9mmPGdjH1d5tCPcM5tCAow6NS+34bNIBm3DNE
 DHp0o3o83BtcBNcPVNL+fg5vGdpc3By/ckggc2d0i4B4MvHjyaH32S/1EspnqDIK
 3YbS6A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqajrqf4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:28:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb7d6ba548eso1507731a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784838493; x=1785443293; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4byo7srvFsnOvA2OhEh2/Innf8ZLtBY7FDx3IcBnjxE=;
 b=Pq1mX94h/J7VzV6Kdo5SmPmOJMCHdorvkBEg+N20XNLCyE/1BLdUwBsxZtTNLY4hpz
 caF3pelT4iotZ1G5ho7BP4VXSlbmv9H7wIpCsQbcYaZGXDcitNZ+ACuTydUkb6D0uNGc
 GW2SjuSBV3RPFB4zmSkvnkSt9C/9VuwKun6nmPki/bXjT3AnrZqCbVqR5KI6AWPXj3HP
 7sKYchnpUlKp84N6jGedBLnsRfhl1lM5WaRZF4tjo5/1zX5gm8Qy0Y12Vhuybb8oFyUy
 L20wRdgEhk9wT9zETt2JUjmk3s7VmLAKmHOZxAiR4wg06lP5oGeLpGrkj25m8AIcENDF
 3PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838493; x=1785443293;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4byo7srvFsnOvA2OhEh2/Innf8ZLtBY7FDx3IcBnjxE=;
 b=KEwOqOFGOf4MfQIzz970Ss59dzSfBoTgelInT/Za4qxc881/98Ga59EP9gNghYTkCm
 dixlgpuEw/HiT+mPYUBTuQG2uLf3kl/LFft7H9+ifiwSNqEvr/X9AF/N8nhreHy52joW
 kRYF3OSYDbrZEHKL3NN/5kWmSH8Fck3I+uBw8MuzBiQw/bMCzaCgVn75BEGECUrFv/rm
 QB27V4xmWjxUWRtfUqu/vG/5Qa8nev4c4CYzvvAvcwjZ6h+CDr3uaEkAJnUcZWhIpmf7
 Xgyb4ZVdNvRKYGYG3rkVlhetFsrWKasQnnIAmQ/pNRi37p/AIfe1CqxG4vCTFs9kJyoE
 UmNA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGUy1NWlzEWd/Vx7mbKF+06D8yUxBmwYm2YEiisqyAq6S0yzi7KknCgMFEALcBoT9oGg/ocK2Diqqa@nongnu.org
X-Gm-Message-State: AOJu0YzKqOY6ezeeY73cVfQSU9PiHsWsJmwPkcwLjaLv5RDVnTG+O2vE
 FvlPS/6OY/QYoWYzCa8Y5TCUQU9x7FXYrFRe60k3MAr/hWs6LhX5lLdh5uJMh6AQvSbIuFIkfQX
 qM+Q9fAG3FNaaLERcDNAGCPh+mVS0JRPAqh4JRaZSWVshZ8yFChtfE425oA==
X-Gm-Gg: AR+sD11dyBLSP4IZzrJprEZlqLk5PwSZ0rQRnMovhhyEUEGNjofTz5gRXH1iJhzXnJW
 Ue03es90wVlVrT9CWgaigPMUp4V67wC0CegsAAdxWXbx6AkhA11YiGNILJH3eFktnMqEqnIldgF
 lAql+jolCv88PYrLA+11/N3zKa1V+5eacyeu5cODpO6vuSaGtemAZYdBXNxC2R7JZCNg2BZ6l6N
 Vu9xS09fKwVclRa4jrtJtqisw/ypURO8tdTJ7cNN4QxBv5NUqlIckULGmEf1WN1gjMeGiO8dfDF
 kYY6B+GNqjM0MWXWiLEIE6BNJTv0pWYAgDcxL863prfgz6yvsmHpPgOYO720w/g+pxGPNCHsnEj
 oHuofI0muVclHT472/B4nkrckK/Hi9FAnjL+L6Wcx3OgjQRGeMlZw5kUlegYRLqFNtK+v
X-Received: by 2002:a05:6a20:2d0b:b0:3c3:68a5:50c8 with SMTP id
 adf61e73a8af0-3c44b2c1f25mr5353274637.71.1784838493373; 
 Thu, 23 Jul 2026 13:28:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d0b:b0:3c3:68a5:50c8 with SMTP id
 adf61e73a8af0-3c44b2c1f25mr5353235637.71.1784838492982; 
 Thu, 23 Jul 2026 13:28:12 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c9289sm23139444eec.29.2026.07.23.13.28.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 13:28:12 -0700 (PDT)
Message-ID: <37a4473b-839f-4865-ae42-50b8cd17a9ee@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 13:28:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gitlab: use .base_meson_job_template for macOS jobs
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>
References: <20260723200904.224413-1-alex.bennee@linaro.org>
 <20260723200904.224413-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260723200904.224413-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WNZPmHsR c=1 sm=1 tr=0 ts=6a62795e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dHClJHATq4Aejph3YkcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE5OCBTYWx0ZWRfX+/bbQmPsCi7Q
 ka+kGNw3Fv8HAMc4ZX8z5ZkOsJZc8hgGMKkKn/NO1qa2WGXq+Z/UA1I8I2JlzzfbA6Xie+Aa4rz
 bjJiyOCuUknX5JBqyyC2Nw17MgX4sPcrB3SgR3cyGJbdzdpDZqvB7l9o4LEDf8gm0Ltn4CknY/f
 ts7r2OhfeqqrqbddIoToBq6j5EACwjj5b1xW/wbSdJodRc7M7Q5QTv8Y3knL0RlAP9PI1ZDVHvW
 z1meBVoUnAZnJvgzJ3DwKKj4wyiIbRlnNWyqTCi7WRyrxkIth0OuEMlGrA1pQp6DRokoFZvTpoM
 dqD/kVxTRDI6FmB0d8irJpDR9F0S3qFlt3MbhtbWTyLAsOlmK57WOmQEgXlccf0uBrZVwuB11Yg
 vae/oJbW8Wh07Qqnb7l6HzsXRSDCu+2FwnQbCGArGyY8jPSPcybfuX/UWocrfV9wZS0+Qqf8biQ
 Y1yxkTG909VZPBxZeTQ==
X-Proofpoint-GUID: PDp9Jc-ZqjWRH1fNEPaCXknHexv1MWzm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE5OCBTYWx0ZWRfX6cUNYE4YScLF
 xX9yRNNY4slGHCBWY/g/5gPPXdZJi/aoXCcl6oY74z3SOLKiZpDGnBnsHfD3nS9jv52akYq37ro
 NAubBeRi7W3u6GXmqvYWk9QxbmI72rI=
X-Proofpoint-ORIG-GUID: PDp9Jc-ZqjWRH1fNEPaCXknHexv1MWzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230198
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

On 7/23/2026 1:09 PM, Alex Bennée wrote:
> This way we'll get more environmental information which will help with
> debugging.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.d/macos.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

