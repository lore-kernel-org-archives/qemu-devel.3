Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C64C531FA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn026-0001xk-3c; Thu, 23 Jul 2026 16:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn023-0001pz-RS
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 16:28:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn021-0000ja-KL
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 16:28:39 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NIm2mO1845033
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BsEJ50qldkewRCzL2p8OAHHD2kkg7wTFLMDx187ucuE=; b=DKUT7iPrGVhUKWjs
 Kh9T8SnlpB0H8Gm3xH9iu0MTxZfOWilOn3Asczu6F51lBRlljN435ontHSp+zcSl
 XP4osINJ+C2p7v/dzQ7nT6CWrzyGN02sJpt2OHXjRmB0YrbbKBpVRfB+/2B0y4ff
 BSWNoq1Zgd2acqyziDRJM01VI69OxSbakWgVuUB/ewhkFQ474oI89fzJgTZYYUs6
 9hZ8ZBi9Xp9HQcxoBHDO4TcKjaGNvCftdYDDD4lux92zMuV05u+2sYWBd5xsIc6u
 M7SzGFxQGb+r37hjSFOM3tPOVhGsxNf0AHclgWNb1DbuXIxqZw1ebe68w4wmkR7M
 nxtKPg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkn9a1ej5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:28:36 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb835525b13so1024055a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 13:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784838515; x=1785443315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BsEJ50qldkewRCzL2p8OAHHD2kkg7wTFLMDx187ucuE=;
 b=T8woeI5r2NgTFSvf8d6I8oaAf/n/ynBTuExObeLL6PrMhvJBAetGISYmD0TuyanXK0
 ZFlPlP0qdd+Fium0JJlejW8YLtmh1Oi7tgmsoN/T3yn70V948J1Js9gs0S6zPqmP9R6G
 8/1mALR60qxEGd0QJGG3nWaqaScN1jUzH2n+MpR/f4yYtVS54K98eHjSqB0DmQ1apfcH
 oGo8btPgjcOzD7SAyFxs2jYj5Qv5tL1tlE/e7xf4YrXTPmx9TE380xyYf7TRwuBEveap
 dmLrFU7ib1cAU/uLP71zuQJmlwqJ+oQL2X2g5YxacUH/LViWve52wxmvYzlryoExwagh
 x0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838515; x=1785443315;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BsEJ50qldkewRCzL2p8OAHHD2kkg7wTFLMDx187ucuE=;
 b=XJI5TF3F54emxzelB9LF8rP3XuMJ8X21FF33Dw/hkZlJh9HiCZxAEbxiIgHyVzwEZj
 11Xq0fSQnthRlHLLjLZiRVMyBdpkT8ZVH7WNrQimWa6vBV/8bnT2OxIgV2lLyeiSPHtr
 EUdPAWcwH6W8szc4NxuKG4aTaiakd6bsQAy6HX3tzK6uIe28bMbqm31grz7X1j/sLxtq
 ioAH2vemHJ48Dnyj4wb+UUYp0r7DcQwEjnfYVEfBQ2tU1K8VV5akbtcJ2Mrkvow4CbSC
 jRJrCmlfGCrCFavuIJ1KZ/Cd/cfyKrKXMR3vnYmLP77IC/Wo/VltoA3hgxd9O2rCm63J
 +qZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwR2oyQGd4+dd3Peycq1sjMhiyv1EDC7JYnyHcFLywNGOz2BF9SoYOI+L8tjGXhQ23HTgIhPTADSYn@nongnu.org
X-Gm-Message-State: AOJu0YxrQaiS/Ws2QddB6Zibcij2ju6ycXpzCejJUeQ/nn1HsA3USUot
 mXBoRYrGRtjOFvLlpM3Zd8ObGPqW3HA1DgqkgHd2jLPXwV+vZmZ11llvYFMxrRTCWeReZxA7FAP
 SZE4mASjjxkpdO0ajP6zMxEb5bdN1Rmf1VrsezjczGLzBQ7RuoinoJ3mSLg==
X-Gm-Gg: AR+sD13B8wjWAoYFOW+9GIRlMslretDlUm5ICsktizoRwfc9zrp7//cSePEO5njE7NF
 4QYNzh8CFwTzWim/WzXvut8/qNDeF6tkofO66ID+WBnIlMNPVtzYvhcXfJto1IxPpWv+xlbDekW
 /aPjA+6tRjduBgYB+cD+W+NoN5gI0IeyJ0tPuVi0SPFDqDjpSJsXhLJe4YAN8eS8GOU3Ec0htlw
 WmbApnb+92kCRVFGjh/rervWYB2JywMBhpGFkU1yjdGXM2Lvj71eMMy1eQGuTqHx8OhTLVEv9x6
 9SlHZ0Vm2HnSjK9iKz+AB4fcDPpU6UPwhpXoS/NVHUpuLxQ9W3YQO2oZkLMcFDga3fOfNW8XVl9
 Yk4yq/2Dz3jvRZWp5D76p7H0H3ZmdYPrfLJ/09AFYVneRZzy1gSCFNbNTkmYxzTKuxiGF
X-Received: by 2002:a05:6a21:918c:b0:3c3:bdce:27c1 with SMTP id
 adf61e73a8af0-3c44b21d362mr5145811637.51.1784838515279; 
 Thu, 23 Jul 2026 13:28:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:918c:b0:3c3:bdce:27c1 with SMTP id
 adf61e73a8af0-3c44b21d362mr5145782637.51.1784838514897; 
 Thu, 23 Jul 2026 13:28:34 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm31099694c88.2.2026.07.23.13.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 13:28:34 -0700 (PDT)
Message-ID: <86ece957-a39d-4bbe-bf52-898a62d70c0b@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 13:28:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] gitlab: add arm-softmmu tests to the macOS build
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
 <20260723200904.224413-4-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260723200904.224413-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE5OCBTYWx0ZWRfX9Z6+Yzarxe2b
 FMV3EIdSZBRvQOejRf+9iXhtbfcQO1Ou3bRZ8rC81hSgstR4Ny1dCw+PtUHrKW0FWzf2FCUagPZ
 FstyuZ0ci/mioKfCuDYiuxf3BMTI8SeSyAT3fssHTAyJFwNKlfE18cAqrsd17RGFeg6QDIiGxRO
 Q0z1rzqftJb9TSHve34FKXADAByoTD4NnsYc843NqBziFvvRzrd59qRjFNATHyILZaiTTFBZn0+
 /+h71CoPfoWsj99gaNK++MglrDcrVQu0s1eGEo+tjBEPN7AHRywc1aeyrMvtexOzua+iQpWOzSs
 qKzzkenR8niuGYaTXhs5B5oqsaSnbqIMp+3OQ3oI/2fxG/1PaPCqkCGYsvZxLEleBZjQ4w8jhgR
 PZFr+v6jQ+qeF5zzUM0p2zCmwONbMj5hTlQDgDn/QRTizuJ8VvW0kOu22wcK14enLaH+Kyswlcn
 jWYAhU7Mp5o4NxqKgsg==
X-Proofpoint-ORIG-GUID: -JR4bQJbl9NR-1pSLLR8hzc7G0Y_d2pM
X-Proofpoint-GUID: -JR4bQJbl9NR-1pSLLR8hzc7G0Y_d2pM
X-Authority-Analysis: v=2.4 cv=WOdPmHsR c=1 sm=1 tr=0 ts=6a627974 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=NwHXQIMkz1UGTOXR-NQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE5OCBTYWx0ZWRfX4i3KcFT+u3Ef
 khwD8JngfCIiw4rgP0/1NEobQSePkyizlxy7mz4JGPF6MS9mdFLJZqqQJe5YxPDELNKYi0utPqL
 5tD6DfKOYHRdFlngPkJ0O6krdxBNtEg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
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

On 7/23/2026 1:09 PM, Alex Bennée wrote:
> Now we have fixed the compiler issues lets have at it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.d/macos.yml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

