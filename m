Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916A3C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8sYj-0008WR-Mj; Tue, 22 Sep 2026 00:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sYi-0008W7-Ao
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:56:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sYg-0001cz-Jl
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:56:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M00IJ62165593
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XEfD6YXujKlrV2F807iXVS59yh64wvpEX06ZZLWXfeY=; b=OW5lINj9sJ+fIs5R
 9geHkVbUE4RqVZ10Z+xG7qcPiBzYZy10vr5TGsJK2QlouM6jDvePhLp8r/ti6ZS6
 Ep3pI7gSbYUyo7D7z6tDFvDzc1S28/FFCI4g9rFSaF5Rb40tjIUABViG9AkQSDk1
 8IHgJircQsF14Z5N6hUMaGjyHdqbeqDa9XMKouCqS4QvUvEWT+NksGoQ3SqKW3D4
 hU/ISO+vO1dzFcWEI0IAYouTIz/WXqA6EL5bZ2X8GcLs9ElvWODvz+0GzE3Q44VD
 JrCRgKzOMlag49bpgOdz5awyxvhHR5U/Dzfg29QmaBiueAVRNFhrnoKb0fgpnrhj
 vYsReA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8xet7bf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:56:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a0050a554so859085785a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 21:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790053004; x=1790657804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XEfD6YXujKlrV2F807iXVS59yh64wvpEX06ZZLWXfeY=;
 b=b4pan8n0pnKAmTzFEP23gusOGi+dGWHX+6xSSaflwwhO1eriD9YqlWFujoTLLFh1m4
 wHxbncs/JxYl3zbqofCyWOZt7Tx+zyJM7bjFFkHNlx/+75xt/QJlJRvmXB1mNDJqlRPB
 5YmDiTsD3ev3v0PkxR5xj5FCJru6b3MCj5FIGUvR57iW7U/ux87ebia1DsljzsR6AxDa
 glGgITJWoSyrBk+NRFRAB4d/azQQ/Ss/mRXtn7Q5pzI5WzjwlhY3AAtC31XYUpSbB39j
 2CCeOX+XMLDG0gJ6LUTHPAoZX7zi3Goi9U8TGrOuvIWyCDm/ScHbL/5WdWycn1BODrLN
 UTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790053004; x=1790657804;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XEfD6YXujKlrV2F807iXVS59yh64wvpEX06ZZLWXfeY=;
 b=lw8hL2vpDA7b0smD1oWKrsX64KsOW5ncREA4A/93Ou1MO9k0BZ4gDWFDYpDI4TAi/u
 PxGQu9IQyOemnOBF/J5TgO6Lo4svXoTII3UWaMa2KEyaYXjIdCrzZlaLFq3UeTCZjKoM
 mP3gYDnJP3QAN5II9h4YAEau7ewE8ByYMaWm5VD7HE3jJ9YNFl9AegTXdb/fAc7ZDP2W
 h2rZq0BT/BaYiGZcMOAwrjVJ9FU5/TvsblazEz/MEudtUGsymP0hVIRoZGIl7Zfurki8
 42v6USJTG98G4ZSG6fEb4kvfC4RPvH3pMjtT4TbgwA4nSUjw9AX7eKPRFJxb/ui0lNDf
 8UQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxC0V5w+p+uMw8jyYK+49vSk7+/bz8xol4VnFrrBfe7BRieuY4LHrc1BBAQYFPaaR01lChJpezKu6Uc@nongnu.org
X-Gm-Message-State: AFuF++kJ+dx9G6yI5oesF67GNQjDub1GSz0pNgbwu3cb6WNBk3Lyf+RS
 IMR8Reo4oYgTAKgr7IovxYrNj4OH66NleRxEAtBgZKzzivI8XmcXd7Yxm708oIOPqlxfqMEFh5d
 qhZz1Tf0vUoTk+yR+OSkIkoZenr8mcIURGhaP3HxLSlPvALNxosyuIYgEWQ==
X-Gm-Gg: AYBFou3vPwkcn5BQwEX2YJNoPrNV7MfHq70g1Zy2dWhDTzcFLuQKzjtnskiWhMnbTI7
 Z8Wu97MzAiWRvdvHiHsva6rED5A1i5kt/DmVOefqAuKNsXQk7YGoZuq9R9rjd9N43bT2KNcQYjj
 8rw1rty9fLPemYiqLvZwYxdicr3/010c377nBtIa2pmcYvqWagaUui7dcpX5w5BPgYpbimJsWnI
 4/jBpFNZzc3Hs6ke555H7uZmHisXDEQ7v5WTtNpDhDjdUDYUNvTz54He73cAuV6/SbZqN+oqy+W
 6IaXzm0utH7mQ1E2E55fTHH+e6KonyH5+JJi6k62ZU3rgivgV/VLFkEMTiMkPG7JsxCHOpjacZg
 e8KekU2wU6HTWMkkgyNAltQ6ENxhzjeQ7BQ==
X-Received: by 2002:a05:620a:44d1:b0:93a:14c:3296 with SMTP id
 af79cd13be357-93c15d5392bmr398418685a.15.1790053003783; 
 Mon, 21 Sep 2026 21:56:43 -0700 (PDT)
X-Received: by 2002:a05:620a:44d1:b0:93a:14c:3296 with SMTP id
 af79cd13be357-93c15d5392bmr398417385a.15.1790053003424; 
 Mon, 21 Sep 2026 21:56:43 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaa99e37sm10850895e9.1.2026.09.21.21.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 21:56:41 -0700 (PDT)
Message-ID: <839465d7-b3af-4ec9-a409-0e9d3f3692f4@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 06:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/usb/hcd-xhci: fix interval alignment after MFINDEX
 passes 2^32
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Feifan Qian <bea1e@proton.me>,
 qemu-stable@nongnu.org
References: <cover.1789968699.git.junjie.cao@intel.com>
 <52c9f935428f2cfc65e4dee7e37638fcb965c6b2.1789968699.git.junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <52c9f935428f2cfc65e4dee7e37638fcb965c6b2.1789968699.git.junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7A2uRdZoUY8q2TtmJfbrgE9Hve_77xY_
X-Authority-Analysis: v=2.4 cv=PZhqFShd c=1 sm=1 tr=0 ts=6ab20a8c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=QyXUC8HyAAAA:8
 a=YSHJQkrxjshRfj3f8wYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 7A2uRdZoUY8q2TtmJfbrgE9Hve_77xY_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2OCBTYWx0ZWRfXzcS7S/RFmq94
 YIPa1gCw6/AjTMb81Pq8oCh42xNnccD4fZj8rAlerrf8wcRN3wlkw8vufekxjtbCKOSdtkaXP9m
 9fAMfr29EnU2GzYj4qE3UVTVP0tXArm2zhlCjb7HnWR5+Ak5lImKmXvYtMNWhOWybSPrS0jIqdZ
 Zd1awQCt78aqr3NchMsgmegskGUI5S4/97wVrKdcMWOOBaLJfF4o3/hjSp3mcnHE6S2rxBszaLD
 K2LubwTHmdbyCEkGP/Zd+6YUCn2RdIhQEFgo1u1G8GvhMnq9ZTadHxO0rSM1u63d7UIfjbZZvES
 bs3ulfo5ubJfxZEQFr16jMu6yuOQ2oMR/GD4dZyLgcJR6VY/5y5HxKy6wi0lwYComL2+2bbVs9M
 RNHtpeVfSL4GoRxirTaX6RlhaMWWL0Zucmk/ZJACDwI5huk9om8DZre9IhYuP5iMGllT7GiNNdG
 AGuhofNb63wIsHUJwWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2OCBTYWx0ZWRfX6fWGDTZ/6YAC
 dKWSKLMu117DV7DAmXGIZX44UDdJkfvdpdFhh2RVMDHqXDskpDn966E9zDmObVsPiQo/Vgoi9M7
 YbJeN9Ywx6TNylmjerl7lgJcotJW0Ds=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220068
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

On 21/9/26 07:46, Junjie Cao wrote:
> epctx->interval is an unsigned int, so ~(epctx->interval - 1) is a
> 32-bit mask that is zero-extended when and-ed with the 64-bit microframe
> index. Once mfindex no longer fits in 32 bits (2^32 * 125us, about 6.2
> days after the controller was started), asap loses its upper half and
> always compares below mfindex. Isoch TDs with SIA are then run at once
> instead of at the next interval boundary. xhci_calc_intr_kick() has the
> same expression.
> 
> Use ROUND_UP(), which builds the mask in the type of mfindex. The
> interval is always a power of two.
> 
> The reporter of #3973 also saw the symptom with UHCI. This change does
> not explain that.

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
> Fixes: 3d1396842d ("xhci: iso xfer support")
> Fixes: 4d7a81c06f ("xhci: emulate intr endpoint intervals correctly")
> Link: https://gitlab.com/qemu-project/qemu/-/issues/3973
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/usb/hcd-xhci.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

