Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC576C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7Zt-0005Yr-Au; Tue, 21 Jul 2026 06:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7Zr-0005Y7-SS
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:19:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7Zq-0000SD-CF
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:19:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LACaEj3884161
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gay3jtCU2MLIaSHa5lHT0Pyb1+Jniu0JwkjjHcWj50U=; b=MhCEMugjN3+dRUy3
 zwMa08D1Jcd8Zlb7Fm+YgEzIz7t7MOaFhF4TcGf4wgffjH2AdcWxg9Z+YQzUqb8X
 aBy7pQy2+duVaPqaky6YpxlNIMZQ2n1tzIEsHBNaQGnOH0Csx0thkxuKqnKvWtnR
 Bk1x9sHezRb8PsfWhPVxcuGzAzWZnCDEk+fguVlE4b4mv9y8RE3qNSKsqKYlHkrV
 uv5OmKQQG8ybqh/wSfHp0fFyMnkuNG/3LjG5NVl2AxnRPPgiNSP044yuxL5aW+b8
 SEy2W6X1N7+ccoKq0i6Dr9DkEkDHoN+XqiRv9aRVNH3+u6z5AGl9IJETvqAk4+gJ
 rlZxsQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqvcbweh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:19:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso161236231cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784629192; x=1785233992; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gay3jtCU2MLIaSHa5lHT0Pyb1+Jniu0JwkjjHcWj50U=;
 b=dm2FpXtfn8Aih8z07NxtpDXVXCx2WCLCnO86zl4MBat28vCsgldL8ADEAkx4rskQQj
 Rw2oBtbBV0zXo2/6fB8pdJRt2AFwFUW72je2JeBzGfA/z02SWYtQobuGpE5NsGyyauw5
 yxKSqdTQvEJ9XcM0L6WfcSy7g9JQD2BpwzBIuG+L4cbpHHb6VLhvBJPudLkX0mP1S+Tr
 SbayXHok6Mr0M98x8j6I7hCflGwrtiIxqXGRjQb6bw2R8CiRvMRDpzDSlklymGNLa/xM
 bcyv4R6K26xKsLoF/EcecK45rHweThl+LQXzevwqZcHautpNuw9T1+D98SgiMwkFYU/F
 C+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784629192; x=1785233992;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gay3jtCU2MLIaSHa5lHT0Pyb1+Jniu0JwkjjHcWj50U=;
 b=HQp6dG0P7pUqKeRyJvtAFS/hD69e9tHVKB6R5rloskC+Vsz806In1Ub3lLr1uitYB7
 eZOjYdhfdp8bD9siAfwkJluK2z2R3nuw73J1uNDsyYLuPgvEbXs8eBnWdO6KzWLMYp8g
 h6KpkATaKyP/0nkC295sfSP2PINscjb90GDymkwtYnmQuXu8TdO7ifaCq9Av+B8BXVhG
 +1iszdiP3TfVOjndXTAdxgoM3QrUNsKuPhxqsfytryKEBEx/bD7rrZ5nJFC/AA8Qyf2M
 jT9OUVgGq06TtrzvPI+mUULxKjhFRcLIokfMQ9vQkRUNIg2c39bHk3UvTSs41pB0mVM0
 ALSA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5tokSBnv8EAfU0VexBhzBxnXTKw+b5rXZ96hYvRTxTWBlKdy1IIAoniuyQ0Sl8vKVoLKZkC9MA6fX@nongnu.org
X-Gm-Message-State: AOJu0Yx9wjXGvBhiULjkTAAVrEh7h/Ti0jVyEvDC4kqwWKXTbNqa1vJw
 y10SKdUjlnm7Z5V+mMG1cggz2E06sgoa9AclX/djmAl2P7Llr2mDmw72bBMSHa9QAQz2KgPMh3T
 vWDAVGIbkYEWb0mrQ45usti49hxXSJpIfkSkBbw5eB5Jlz9OkGg8Qtd7Xzw==
X-Gm-Gg: AfdE7cnyrzW8xmtGmC+9j7Xv8e5Px0F6/b9sKWSh364HwgVw1kZ7GQ8jbg75RUn9NZU
 iR3CCpKsSLwbizkUDFsBghSfP8lBlcntsCywTVSedE8ev3EsEMxbwFWOV1YmqLL+iI2VK/9u8cM
 Sf9xJfK3UOdAhL7h6icIx6kbd+DfIQCWTTu+qVMhkIwW+dZiU9vqmdtINJebZPnwc7IGOGnVkel
 waLGsS8AOjdvLtw34P0E3DlosPLkjamKd2A7rwcbVvw/YXMeLCToFa2sJRyNUraYB+2w1SmjcWm
 oeQfaaYc7qnPlzZrHGlnN4jTaAdxMxLeEMgmuR8HopS7hdmnxLBW5hD4Mn3dU08IL8C4VSdm/U3
 BsAcnFJpLRQ9VcUnqHjjQC46vnEyxthmhwtRzAGniGY+oU7cjZNY=
X-Received: by 2002:a05:622a:4110:b0:51a:8b64:69e0 with SMTP id
 d75a77b69052e-5213d2b7109mr165033601cf.11.1784629192407; 
 Tue, 21 Jul 2026 03:19:52 -0700 (PDT)
X-Received: by 2002:a05:622a:4110:b0:51a:8b64:69e0 with SMTP id
 d75a77b69052e-5213d2b7109mr165033471cf.11.1784629192057; 
 Tue, 21 Jul 2026 03:19:52 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c98ebsm52020745e9.13.2026.07.21.03.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:19:51 -0700 (PDT)
Message-ID: <c48ade4d-52ff-42a6-9fe2-67db70c71c8d@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:19:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Correct padding check in qemu_receive_packet()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 Jason Wang <jasowang@redhat.com>
References: <20260629164246.2028947-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629164246.2028947-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwOSBTYWx0ZWRfXxaK7PCX9kM59
 tdcJq3vHQWuHv0we2VYgM4/B2E5nf+kbgE+fIJAIXxRUhhsVvHMJHegGBTt3afdaJURwNVrjA5o
 qeBVPDYVoDkgB/pxl4pyE0Bwqt9/qro=
X-Proofpoint-GUID: sIdRuhflVN6EiMDOWcPNi72cRQ7X_att
X-Authority-Analysis: v=2.4 cv=OMYXGyaB c=1 sm=1 tr=0 ts=6a5f47c8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=Bg4sYZIGnuBg2hlKu24A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: sIdRuhflVN6EiMDOWcPNi72cRQ7X_att
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwOSBTYWx0ZWRfX1+d4IQLzBJ0z
 dWf17y8kvDrkIPXdQlbiKRKH07k6UZeem+mZTN7vuxYGiqAm+fWpFZb0XfuVrHhvPEiZSZHIZs3
 d/p9VdhSg5gEjVB0QSQx2a8u/jJUig8D9LOP2TGKLS97G3TLTqdhvexYbYzy2k76mcp4DaUPKyy
 xUKrFX3sso4ydDVO78CsXeBjE15xReiSYfLDEpcsaPWnkVrx/+pncOCSZpjLaGEpzSbvHABZjtA
 cCQ5pCsljet05vlDnfKMhx++aFY6SP2HxrCHEL752dZG+iq05Ur5KDhyugGnFwecYQf+I/FKTBq
 icBwJV+/njVxT5vKsjYFZrBHLGHw4YM5FWw7KMb8RKV0ZJGcweaUrN3MSp582GOXfU/Ic/wRWe/
 UevlHO3j45MLcI24iQTjzViPecOKM3JTnRa+LM6nN0OCbHwXYj2Y7zfobjxnqzy6REg/kE9fk41
 Sq5nhiHc1rfzDDrauNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210109
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

On 29/6/26 18:42, Peter Maydell wrote:
> In qemu_receive_packet() we check to see if we should pad a short
> packet.  This is doing the wrong test: because this function is used
> when the device adds a packet to its own incoming queue (i.e.  for
> loopback), we should be checking the NetClientState's own do_not_pad
> flag, not that for its peer.
> 
> We didn't notice this earlier, because at the moment all the real
> peers of a network device (i.e.  the network backends) do not set
> do_not_pad, so net_peer_needs_padding() always returns true except in
> the corner case where the network device has no peer at all.
> 
> The effect of this is that if a network device has no peer (e.g.
> because QEMU was started with -net none or with -nodefaults) then we
> can still let through the kind of "guest misprograms the network
> device to loopback-transmit a short packet and then we mishandle it
> in the receive path" bug like #3043 which commit a01344d9d78 was
> trying to fix.
> 
> Since the distinction between "we should check nc->do_not_pad"
> and "we should check nc->peer->do_not_pad" is a bit subtle, add
> enough documentation commentary to make it more obvious.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: a01344d9d78 ("net: pad packets to minimum length in qemu_receive_packet()")
> Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/net/net.h | 23 +++++++++++++++++++++++
>   net/net.c         |  2 +-
>   2 files changed, 24 insertions(+), 1 deletion(-)

Patch queued, thanks.

