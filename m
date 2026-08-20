Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB26C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0ic-00035J-GT; Thu, 20 Aug 2026 07:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0ia-00034y-TQ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:13:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0iZ-0004Ma-DP
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:13:56 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KA2qkW3132051
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0blio5NrQHkTVF1/FTn9BfucTj5CI7RKiqO059bWiXw=; b=YxjOv4buSdozbX2L
 PJ5HLWLclJVXLKBwPbIS5uJgIhxedEY03tZEhjStkWEegE/35WOVWNKbQW09XLts
 hhdFIE3qkzY1tEGX/EbVgJEnYIPBjRfeq3fykztDvI8UKPrlCMVhduynizcM6rer
 hey7/OH7/U6l1unB+k2GI8URotQ2+48PonV7KVn3RxlHenP1Ze8d9CzN+M+YP51D
 HnEoYXG9bFFQb6XIdb1TAK/hO70IdUftqnlwmzTuDqBgqjVfa02Dlur2ALPPEKCw
 X0YJuTyTFgPkL8lpajXvVUhgcO8fcE9PKverauW0tvesUbg7iTCGI4RM+FCeYoV6
 /pf9Yg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg188ju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:13:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9308eafb465so437461585a.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 04:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787224433; x=1787829233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0blio5NrQHkTVF1/FTn9BfucTj5CI7RKiqO059bWiXw=;
 b=BeG1YRcFkIIFZShZC/mHAzhpT5w/tvateyP9r+dQXWD5jYNA/JpijcJ8doZta17AXL
 i7J53ITQnLVkvznM3gVapj6E7gKVqxfrFnRxT9cYZxLc7gjBe3L4JRHpP7sN5ExBh7hZ
 xbdwfIHizjjVJ209b5oxurEELMaWrfXXruvUTOlTQ0ppZHme1fQoiGpk18AcAlRyVrsN
 OspHHT0YhrlNse9Om0eQKooa6TCLMynCYBQJFEnqUyWryCxku89xV77mIDE5c3ZfOOAB
 aolylRmS/h7l9yE1vOktdZw7gHk4XrRaShJjJzxbfCN4mriQ9yqkReXl6axGWO2tRqKz
 GVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787224433; x=1787829233;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0blio5NrQHkTVF1/FTn9BfucTj5CI7RKiqO059bWiXw=;
 b=Kg9jj8/hevBwJ5+FU3O0nnbTbiR7O47YKVO9XAlsVkQKTW/MfzwFYZMJFOpeKhpqWn
 slrNAtg/Du2hSM0FNBhTRQMRfWzUrq0uomdXlW8WtsUN175IfOFZBzESQ5N8MtBPA2zY
 rRpZF/oE8AIGYFXwu9KXwzJ3ZAFWjlkgWanovoISCgO/5HceQDREH+F4LTCvMYIGicnq
 E2Bc9YCAobyuQocFddiImAfgY4F71mnh8pPHfx4p0j930iYstbiBeKMJXnngNUhfaONU
 KCtoOKtimbsmCJtUHsXZOYHywtrepQdYoCGFtFWeRUJV7RxKeB1DEZkEOD4aXbPgUDSi
 VnYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBKzbivyWukw17G/9mUWq2BsxHvZBFiIGO9UUVn4xDaGUnfLxTMqMMDPIpcoWBL8yzX1ylnYfzHdBN@nongnu.org
X-Gm-Message-State: AOJu0YyKH0qfSmkd9RcBfOUpFtfDKyh7/0bAY8RvlPp6TyzA9Cpvau7B
 fBiRKUlAXztgrF/vsOB9VCJuJaJGtKbdDAPJ61lDxIKeKPbJ9BPFJFCtHH/WM7OUvTOt1BKWLN7
 E1fkHHQAu1eyDGHXm5mp6cStN4g24LYYsPKwaQD3dvfUCqiFVOYPQwj5jjQ==
X-Gm-Gg: AR+sD12TJZByz9Bw87oUvuvljX1BpOCg6HUlb9wLheCQo6YbmIGKfLlY9wgItNVZZZj
 lgrUyHwA7k1+/X1wfALytxli7NwO9mNP8c0vYkg2lyKV2uS9xe3SrLnkpAm475L2lcDZwCmWGjy
 K28TYn9tHY67qc6RTXv5iHiZc76vBZRHQtWb2k2c4EWO4pgdm2bbdUwrQnUbX425QVXusLw+fLY
 lYNJlxWqFpkjAF9oQZ6IlQXOzHE3qCkLZ0SdhOOC2m6V/by4e3kBDdesRlfu9Hni3SE/7//DEXT
 xmqpJ96bXzlQ/W8UAG0g1GZOhUVFx8u7JHqMB1Gx3onGD0VtaSbQI8392cAykBlMFFAHArEv/bl
 neWz8atASU/lcXwH7nfvb//Q2aU0nYRh4ZyU=
X-Received: by 2002:a05:620a:28c6:b0:930:f129:1a45 with SMTP id
 af79cd13be357-9371e2ccc34mr1121248785a.30.1787224433182; 
 Thu, 20 Aug 2026 04:13:53 -0700 (PDT)
X-Received: by 2002:a05:620a:28c6:b0:930:f129:1a45 with SMTP id
 af79cd13be357-9371e2ccc34mr1121244185a.30.1787224432781; 
 Thu, 20 Aug 2026 04:13:52 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b2b96537sm34550185e9.1.2026.08.20.04.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 04:13:52 -0700 (PDT)
Message-ID: <ebbc35e2-18ce-4e9c-a2fb-548dd2b47a47@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 13:13:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tests/qtest/pflash-cfi02-test: Don't use musicpal
 machine for testing
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@web.de>
References: <20260819185430.3467629-1-peter.maydell@linaro.org>
 <20260819185430.3467629-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260819185430.3467629-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Z5nJJI-xbryvfBztIKauE6lQmEKYNrp2
X-Authority-Analysis: v=2.4 cv=G7Is1dk5 c=1 sm=1 tr=0 ts=6a86e171 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Z5nJJI-xbryvfBztIKauE6lQmEKYNrp2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4MyBTYWx0ZWRfX1g2CbihL6bbl
 nt5VXF66uFfNuA2sX5GOWFAYF4aju/C6THHAv6m4FniDmp6ByGFk42FR8m5Kjc/Ce392fUtUUPy
 VaC0R56gU5V+U3JYHiSURuP7a/7lrTI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4MyBTYWx0ZWRfXzK+/yN1brXyN
 l06NA8Pq97M0F/0VbQyDIqEkpvyqdVQXYU6OQHgeS7gsog+hdSUw/wd9OfnV6Wa6dT5wZmDAK3t
 wA37a7js0df4b0cu02i8SepHigLJEd5GGPBv5Kq/+x5YH5oDERt0TCKgQoy6lx8M09ku0+z9ru7
 ClbZwe4G0q+IkUxBr+twxP36taRWitlVl/tMZpwxjvh3i41khEpB/SVMFS/NZRLLbnVhlWL7wmt
 OiDMadeqaVhgtvc+azB1MXiDiDFJPL3SmjvQjZ6xbU3l+YQesvjSKZHHZRB/Ox4sKtsIIK7qChT
 bIZh3Q7NkUN448H59AoJLqloUQz5+1L6tTPEFilTnGsObDS2HTbzMyg8zHgGAfSYcGsjDhUfmFP
 Oj63d+tGgN5wpdvhKWrfrP/YTaiBadXpp38elWGdME+wBlu7oKTC3OB8Hunpp6nEF3utGWPGYnC
 zln/xRQSReT7msj5Kpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200083
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 19/8/26 20:54, Peter Maydell wrote:
> We currently use the musicpal machine for testing the pflash-cfi02
> device.  We'd like to remove that machine, so switch the tests to the
> sh4 r2d board type instead.
> 
> We use r2d because it happens to have the same "2 bank" config that
> musicpal did.  (Of our other options, xilinx-zynq-a9 has only a
> 1-bank setup so wouldn't allow the same range of testing, and the
> canon-a1100 board both doesn't support specifying a flash drive via
> -drive if=pflash, plus it seems likely it too might be a candidate
> for deprecate-and-drop.)
> 
> The r2d flash device is not quite the same config as the musicpal
> one: it has a different base address and size, and different
> ID values. So we need to update the test to match.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/meson.build         |  6 +++---
>   tests/qtest/pflash-cfi02-test.c | 38 ++++++++++++++++++++-------------
>   2 files changed, 26 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

