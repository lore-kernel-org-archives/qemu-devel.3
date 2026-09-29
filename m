Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C54CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTFp-0003WH-3J; Tue, 29 Sep 2026 04:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1xBTFm-0003Vr-Uw
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:31:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1xBTFl-0002fK-Dx
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:31:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7TwM0301413
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=jll0jYxIyZ1BKNPPmlJOlFka
 kdBQQX0jytHpSKdT3Q8=; b=EpsHStMKph8a/kyNosRXuzchFD6JjPLWOd0vwSzj
 MvyB8GtdV30qv4EV4dmTxH5czO5FxhQFN73S+emuArAKAlqtQRP2MLqDdypDoRE1
 /3E6rYfNHCYRExKg0tvQDf513z+TTZF+OdXbyd7UELIfP/1zc490qUGoUQyWWtHv
 /k6jIccYDGwKAXqudbg3A4CvYzbrb0xLMcEC4T4uYBL8Elc70AjPX2cgHLIh+Abq
 D3YDTNgo8/Pdie0IsC+YIwAqEp2cx/qJdQ1R+zJ6Q6DUJonPWoVZGk4jCUIzJWrx
 5FMparIFuRpxzQtrFaH5H7kQwtcQ2JIozwpgJR+hi8Hamg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxgyqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:31:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93bfb2da664so1132209385a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790670714; x=1791275514; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jll0jYxIyZ1BKNPPmlJOlFkakdBQQX0jytHpSKdT3Q8=;
 b=aMdYYUumZSh4/oYBR08+qLgMSTp7HHAqIE4tjhRviUjKvjiq+rHLKANKkU8FE9Zsl/
 +qC1A3aoFzENGV3iwBh7M0TIzP/okB/qE2tcWgUvUlUiG3ziFHrf5fjC8jB95LV4fZeN
 bH2ROxtu9KxZxgYkCXHhXvClYc6WXcwdyVZ9fftokeMSx0AWPO8AU5wOtJSnPWpK7mH/
 9rKJD8UWpiEqYxKD1sGSz5+B/uAs9DJydckmDZ3r5IRfXufy6ggfkCEaYnga0QrqDaDG
 psoNSMdOpOMuuY0NhO41WSZ2uqYzCVkzca8Tz1AtraiufIe446O2njmkLzZ9s5RaGNdl
 v7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790670714; x=1791275514;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jll0jYxIyZ1BKNPPmlJOlFkakdBQQX0jytHpSKdT3Q8=;
 b=t04JWVG+4gyr4RhVl0Zj/qGfNcKivxHq4sikEzgeXZey/KCsi3F3HJzZr8xqzXxTXI
 ZmBllgczds9V9qvazbeQGEd6aRjrLZTueOzBFBiW3SMVNUSY7KjkwtSoreLAceCrbEVp
 r739ld4sdLA/SqlEG/Te1A/Y/q15HKBxQnIagr1pKgedy02Dz8WIL/VcFCUa/JjW5X4x
 zwY65KfLWnGEFqZs6/fCAtNqijpXiPX6EYGM0NjLHCUr411qil0E4U7PdBKUY6emD3og
 XHg2rpUKUhhWO8/9ssQ3hOQfSKR1SWVTHayTguh3mp8fYLhSzeFAG1FUC9W9Q9hqaDyg
 XVrw==
X-Gm-Message-State: AFuF++n1tz8NZBmVr0qgiBsD3ydzyCM4LS/1HhL2fXWmiXYJ2+HVGu1q
 BnqBosjFnbV1pgETCwHD/z9WGP3v2iZw5Oijpf4xS5mJNIwq7YQePDsEFyzm2rBQQDq/FJXAnbp
 gu7peGDUjTCF+s6Le/3ZIW7dcgekof8g1BSFrdQrhWbYuClyyDLVigatFUTZNLAhOQw==
X-Gm-Gg: AYBFou0xdFj0jM5SMAam2YmItSqzBJ0/ZUFxnIb+jMsG5O8q3+ATPs6wqd3l029p7Z0
 hO9fgFxNcObCKPbRApnOAT92rPyVBJ4kRi8x0YTGoZ9B3UBtj+dbsNyuVSggrFFWFnozF7nNZaX
 3So7cK6n+/LAC4qcN5EqChqjLXo7b13xrfP9gZ/C3GSRH0LKV/EDh7sdrmriosmscoTUgtGF1i6
 TVVDFGUMNHmBHECSETzpSfiufFmBr63SR5g+Ffi8X6mI2h7LC93K65nNMkGQ+Z6Tsn8UbUdI5J1
 kFpPQ7m3yx3jFj8rAFoMdSt/VxiV2pQG6ZC1UpR+h9Vymtwl5EdbqcpBEX0c+DDSJQKmMM3Vf1C
 TAgZna393G/TnDGQqLkkPrAWTFMBTnG1Vp6OHWA==
X-Received: by 2002:a05:620a:6602:b0:939:3a81:326 with SMTP id
 af79cd13be357-93c47498e61mr2179918785a.37.1790670714161; 
 Tue, 29 Sep 2026 01:31:54 -0700 (PDT)
X-Received: by 2002:a05:620a:6602:b0:939:3a81:326 with SMTP id
 af79cd13be357-93c47498e61mr2179915885a.37.1790670713705; 
 Tue, 29 Sep 2026 01:31:53 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6acb9036092sm388625a12.26.2026.09.29.01.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:31:52 -0700 (PDT)
Date: Tue, 29 Sep 2026 10:31:52 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Stefan Butz via qemu development <qemu-devel@nongnu.org>,
 qingwei.hu@bytedance.com
Cc: Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Stefan Butz <mail@butz.st>
Subject: Re: [PATCH 0/4] Support KVM on real RISC-V HW
Message-ID: <zqlgon5k7dhqyxilnlyrmxd7brnpftqwabw62rbmc3khxtz77t@pyr4an4sadxv>
References: <20260928-spacemit-k3-v1-0-8c57d0596b87@butz.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-spacemit-k3-v1-0-8c57d0596b87@butz.st>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMyBTYWx0ZWRfXzMUU2NQjnJUV
 jrHQlvWpvsTCIOimcETHNES46LS7DmH+3fZFnrFbRW13TebNgfXX+YdPeqpScgB26lngtC86t8C
 G5jci7DMmV5rodw1WKFFQr5jH6YzId4=
X-Proofpoint-GUID: navwSQ1a0_go-s-m3zyf6g1vcxA9SN-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMyBTYWx0ZWRfX30r6mylN30KA
 oYNh0v0Y5uFlLN7mqIaIVUQkrFlXYyU3YpETZxWxk/i8AHP/ZPJA2Dvt6sidcIYNjXESXznBP1W
 yghPA2myeHAb8rQjRxgQJ3q/ctn8vBwdYjcHcBhqDAu3zH1SZfm1u0bIuuIIsfeb3iollxDcF5H
 uMRZpYVWzdVtK+Ku7jbA+iLjTKnJktw10aG9P85f62wjrkiGZgJDpA6OpwSzMQV4Wx02XFCI3eo
 BK9wVUs1HYECj2bm8KjnH9vJG2+O6a1Jc9rFG25lxWj4aA1ZOz1zjjaImJADTQBc13g/OtY06O3
 Qhfhm9P6lPE2pqxytJogoimVvpjO8Qu3zcFBaDur37mL+IFAGkyKZeaZZOv49Z49wFuJbT0TC3R
 Aq9YPzZeFFlryvuwIRHfbXhtKlpTa8ydxqXrwnmp9CPWSGTFC8HTtqbCXk0HsIDo8igGVDS9qDZ
 lN3tGSN2gaP1WrFXvXA==
X-Proofpoint-ORIG-GUID: navwSQ1a0_go-s-m3zyf6g1vcxA9SN-P
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abb777a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=T7-AkUZC2QL64gVNQlYA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Mon, Sep 28, 2026 at 08:06:35AM +0200, Stefan Butz via qemu development wrote:
> Spacemit K3 and Tenstorrent Atlantis support only 64 guest interrupt
> identities. QEMU virt machine always requests 255.
> This patchset queries the hw limits from the KVM AIA device to avoid
> requesting more interrupt identities than supported.
> Without this patchet QEMU KVM crashes on those platforms.
> 
> Bug Ticket: https://gitlab.com/qemu-project/qemu/-/work_items/4599
>

Hi Stefan,

Qingwei Hu posted a fix for this too last week. Please work together on
it.

Thanks,
drew

