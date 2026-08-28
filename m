Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BF3C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzr0u-0003Q2-Bp; Fri, 28 Aug 2026 03:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzr0s-0003PX-UX
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:28:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzr0r-0004bY-8q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:28:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S66l3N1941010
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0/p95gJgexpjzl1CT+x7iyIKmrimwtCtQSWYS53Aq5A=; b=lyrd7UzvuhyLFbz0
 zruZURjp+Gp5+tcP1nOzWS7LbmrU5tc0YTiKFl7f2dvu4PtXgKDKsrH1xxiYJieo
 s08qrSrEujuMrGdST+KzfHpsc6AHhKVp+PUL3l/RFSv/aMr5WEYbOHmit3Aa0SjF
 e51MnUXl1ugf45qENzGX4F+2AF63hMg5RZejnaiEoxC2UFoNBlDfSNhkyRBB3zpF
 6YNfE55341keXzoz6Q5dJxcoWQUhQQhAqLpaxKdjoHkmthrKdaCy42XJmS/oVAJ+
 t0X4RKQKM9AyauOYegz7sd+Gme+VS7ejgR6yftQnnU2x+TUjhreC6AbDCuX/ODrG
 h5uw2A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3hs0kp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:28:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso4396071cf.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 00:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787902111; x=1788506911; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0/p95gJgexpjzl1CT+x7iyIKmrimwtCtQSWYS53Aq5A=;
 b=eR8pKwTNNrp+OMlS7dN3gvMUqIKUB2PfzeflLbFPUrNLNUBbL2peImsjyvCW1VejO5
 uW7mW6fDD67X5dfF1Zf5UZyiFLyKzRk8iVYI5lNxQA4pObWNVdj9YfZCbCT8n+25Z1bd
 7wxHzkh0nhvVCnDR/QTN+tem1vWuVV4Ll41tiNBGw0ghxCQiKQI/Ln4HZ2T09ABZ/p54
 qOjKFUMqdVv/ifyXOvfLlsD4ZOUVRrdtIL/+m4tbNRX15uc8mp9I4iHPgj+/Ldr5r9Mz
 KfW64twmG/eT/P6dXmt6LuJTJM8lsik1yx/y52nRZ3oZmxd3witgOz4pBrCGzTlRIT7l
 /VFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787902111; x=1788506911;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0/p95gJgexpjzl1CT+x7iyIKmrimwtCtQSWYS53Aq5A=;
 b=GaiD5qg0kUSGEkldiC4ZTYZI9luM8iTH91f8g6xpWyIUaPZ5IytqoJF0m7wzC80SbF
 cQNYfRceGtOcZWGDSK+9WrLpxxihk8LcsuJxHpxv9097k5Rhhj8g2326gPUs13gjOpD5
 cyzKnWFJWfNpQgo+EU55ASk8ohCE0weEC9NGRfIBxp4Zno6rvclSNFT907ECmlSSeztg
 rYI1o0Zuo/15pNu0j1a9aPUnuO0IDW0cq/6zGH8vWZPFbsiIDCGcT7xgxzThx0YRHu2s
 cPTanz6HShkp9+JEJNq9J2fIVYKTJgOtEndhuYj4WLcd7BmoSI+R06ONpzVqwiACohE7
 Q5Fw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8nGqu5iczIoiA/vE7pgZFIeklrcvasyxwAVl1SbYrER4zwS28hAfuKLrIIfLsQcz2q1G9jtCum74C@nongnu.org
X-Gm-Message-State: AFuF++mmaK3PYqxFjKawzhhZlyf08HTlQ7b8lLm9OVGwg4CSCvx7t4lJ
 mzXZAH90m6hZR4O9+0TUcEkT+GeRu1jFQJe2wH8Yjgm65fqqQnboSOuMQnqskfsKaQQftFSdOp2
 NxTrxC1O0Q9QYvJT44aEAg2WcQ4a6gtXUY1otcqHdpAHYI+RzENicKo3avyOywfrcNg==
X-Gm-Gg: AR+sD13Ovu/nh70FPLx8ccc2B5zsNdYhEvhlIAKjHk2k3MSPUpovOLwzhqKBKuZs7zK
 qNt3gIL64nhW5XoxhZa7LPnqauXIM3y3nZPUbo/clCkPm7XKS2WlkR6Gjmk5U2k0lcv/kYv+6LB
 8+YAQYaf6LClSR8fL8zxXTK66eQfbO68F4ggDXy06/exzq2iQbkD0TWEauDvwie/6YlBc1eIeci
 m9+J7NokIo4bkL9A7j8zuorFuShGtyE9u1bs6jgs8hpz3qhtEAXnygpSnj2KiIk3v/EyErxwXmN
 sj1T2XlYeayPqWNxhoFZ2AvJqVU+hutlxvJGRT1NiXDVo7Lb9203KR1JxHQeqIoM5roB/buUwU1
 0VHbbVXW0EDm1Uk7wg1tO1CLsaPsXisza+Q==
X-Received: by 2002:ac8:5883:0:b0:52d:86ed:8394 with SMTP id
 d75a77b69052e-52fb96ae59amr47658391cf.36.1787902110794; 
 Fri, 28 Aug 2026 00:28:30 -0700 (PDT)
X-Received: by 2002:ac8:5883:0:b0:52d:86ed:8394 with SMTP id
 d75a77b69052e-52fb96ae59amr47658071cf.36.1787902110306; 
 Fri, 28 Aug 2026 00:28:30 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2e6e8sm2140922f8f.32.2026.08.28.00.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 00:28:29 -0700 (PDT)
Message-ID: <ef0f8078-b70e-4e17-86de-e8be99c7099f@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 09:28:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] target/arm: Build cpu32.c once in system mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com
References: <20260827041557.775080-1-richard.henderson@linaro.org>
 <20260827041557.775080-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260827041557.775080-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XKYAjwhE c=1 sm=1 tr=0 ts=6a91389f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA2MyBTYWx0ZWRfXxFCqY+3J6DgE
 +nEZaleWkhjlh/YPDuTzEVBk/ANJVdcc2frt2b6nAMalsaeXypYm1A3/5cN6YG4pjBctgOtIKXY
 AmxQyufyGwqNoPMOxfHcZNHzVyL0nDq0tsbRAVjltQ+Ur5zPURn0A5NRGL1o9ypzfASO1YodrAW
 DkkGsV+nq8w2tiA2Jk5FppdJYtOcSTwREj/elKTUS08rYQnLlir35mW0Pd4I+ziusTCKyiwH8IV
 9wYABwznz5GUCmCIpBVr95okLr4ra4YfOiV1/VZu3G0VhcYLgk/4c2yMn+pB9GBwyYZXki77UgP
 HPna8DKq88JdfD091qP1G+txzj3A0KueF9uEktQRyVjF4Q4QK9001xvWL22PQxTOxkeuKW7LKKi
 SwSbdicn4aRraPKlLSwhxFSM9cavfCl0sfhTc567e5tp0N8JEs6TyQ6GcbouCm+FRxnQnscoJ7d
 Y+ruF0DUnlXABvVu0fg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA2MyBTYWx0ZWRfX5cihGEi6wEqY
 cgT9A0zEfUyjW3cKhzljbX43rHLHpr5gGz3fipUqe3zfNxeSsBFzZ3cLBnsmcMWC2GVXjxs6EML
 QJtemdQcz40G2cC8NHVUY2cuaObbGUE=
X-Proofpoint-GUID: wGM2vHMSDYYxOo4_FjriqZL8afg8ykQI
X-Proofpoint-ORIG-GUID: wGM2vHMSDYYxOo4_FjriqZL8afg8ykQI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280063
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

On 27/8/26 06:15, Richard Henderson wrote:
> "Move" the ifdef to meson.build rules.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/cpu32.c     |  5 -----
>   target/arm/tcg/meson.build | 10 +++++-----
>   2 files changed, 5 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

