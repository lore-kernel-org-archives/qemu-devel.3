Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2448AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJXd-0006bL-VO; Tue, 18 Aug 2026 09:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwJXc-0006ao-NS
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:07:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwJXb-0004Ck-4Q
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:07:44 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IABXsP581253
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OgOEJl8eizJEofXwS5JCE1z8JiDMTg4lwZsWuuP6CPs=; b=STgY3bJUZrtEymNY
 kULfTXP9APDUiG5dbN+Rhtj7fr93q20/q0nRlienxZuLlRZPWcnmFpIAkD6zAwhN
 mGyI1IH39JCmcZcOWJ89MtMhfXUJMuYWxGPxTBIkrv5cI0GoJU9J4+xdlEcP15MG
 p+/kXH+uyDZZZTXNhfgCSrdvYmt1tLBdeyhfb4fvedNSvs/tiQ6VAD4ihTKdE4LD
 SoOKkHUoE8gzKjP26D1BpkEhw57XKBkNiymEG3oqF5FrcRw1iXZ0pRICZuxs731t
 XMbrbG8YyFkPF4a4EkQVFWD4D0z9jZ8CQLcWn6YfBhXF/vxSBaF/iFUe5tEncGhs
 aghuUg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fbaa9kw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:07:40 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-74ab744f2c2so872634137.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787058460; x=1787663260; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OgOEJl8eizJEofXwS5JCE1z8JiDMTg4lwZsWuuP6CPs=;
 b=RMgiLTdbIyepwmfxBjK367ODq6m0zKjD50fjuZI5EsPskoEYVXK6kGMnEAjmT6sFAV
 q7/UTQ3kVFKhCxwlWtXkwGXIdJ/oNNBij1dL0NOhYCM0kMcyTaGUTUX971xuuk3I8fvo
 ZIBfXgG8P6H+xsfQ7m/f+VCpgdm1CWc5AAYbVHGLyEpoy+QTbesmBfYt5PN2jg22VSX3
 0OXJKi6Gz1GuhpQUOlfEYlKxVPnt6blNAhKTGjbJUH8sceFGTmliVyjiUHgbc6FeiwMl
 Qzm7v1HyAgXm/LVgJkBrMiyvmx2eMBtPCuuOlnwvs0kZ5qisY7n6IWwqGdoBIAwhEGUP
 WgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787058460; x=1787663260;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OgOEJl8eizJEofXwS5JCE1z8JiDMTg4lwZsWuuP6CPs=;
 b=lH8zwBgOGtaGX9eF8TgM4cbIXmdMRYFgDXU2YsOlXxQIkLNXPv9kIpPfyRiA56zI5G
 soQ7B+WkhPW2NpjTEBxloczbHEND3SpDrsJzuAvREr0LLVyIhvSQ8ZCh1hesPoftOMWG
 MkknnORtHfr5ZM26z0hveXUqgLKXT4KXFT6oxSkaW2Pe+qJd+XhkBd/1N1xC2HEh3k/G
 XsEbAR8psYLClVk8jy+rx4OAz5K53Xc35ly1/anyOvvcNr163/pYIBVwt4YrWzHecv1s
 Pd7l/GkoiPxeU3y68qx1RCInKOZhosohfLNJUEGDP2BaGLSZ4wdp/KpDoanp3eau5Ed8
 dWDA==
X-Gm-Message-State: AOJu0YykjSNqhOMdnt+06PtELvRd/SHG9RzbMrTe/iBI+Glvw/xoZ7wF
 BB0tlN52yF7AxkyHQeGLvlP7UgnM95Xj2Kp/hzvVuTLI7IWBuBri/vp8spT0eu1w6M2f1L6oW1Y
 zdCB/3gYtfqnG+mH7AIex0Qm6I1BP8hlrJYl1mNopghpo042ap5A43HqUUA==
X-Gm-Gg: AR+sD11qvEdnMJ9Lvj3HPFlQtZGZds2XiVuB066UE+hC5vFJ0XKkBzzbqnPJ2RccZ40
 2SqeYYf2U43ZrRn3fiEpMAZC5Ka1BGoGDL+bD2He/2m+hPRnbV4kA/fOqyrzucaPyXc2yHlTnZ6
 Y9lTaXi0QrH38amCU8Sd8+Kh9jkt0HX2a7j2U/kCAP4zb0fZcKw+wW/bDS2TSIb0UIn9yK7vabw
 rUtUnBZM4p2zUEZMcwZeJfLRTPYiN/tE3AJDAv7bFcB0LV7YkX3NikRszLmzJXRLG+JwG2q3WtU
 FYABEvqPkSDapdlrjoasuk+IvyWO10zuPkC9tDbOKv8Qe8hfDv842FVThXDWRSbVKxmY2XwN+F3
 FSBIIVNc21LPxX4bl1JKzh3ZmYk0cfJyEfkM=
X-Received: by 2002:a05:6102:3fa8:b0:76d:154:7f42 with SMTP id
 ada2fe7eead31-76f2b2fa5dfmr5922211137.5.1787058459579; 
 Tue, 18 Aug 2026 06:07:39 -0700 (PDT)
X-Received: by 2002:a05:6102:3fa8:b0:76d:154:7f42 with SMTP id
 ada2fe7eead31-76f2b2fa5dfmr5922177137.5.1787058459089; 
 Tue, 18 Aug 2026 06:07:39 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b203cfsm296961215e9.3.2026.08.18.06.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 06:07:38 -0700 (PDT)
Message-ID: <b268acef-e255-4c13-8db8-09f2974e7218@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 15:07:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] accel/kvm: Consistently return CPU halt state from
 process_async_events
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Alexander Graf
 <agraf@csgraf.de>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
 <20260813181640.6537-12-philmd@oss.qualcomm.com>
 <55cc8357-daeb-4315-9f3a-8be7a59c355b@redhat.com>
 <3ec603ff-65bb-440b-8ed8-72ae4e6c5a41@oss.qualcomm.com>
 <CABgObfaDAhrpnVqQaKgG6uxPQe1YDu77YOsUEx9nqrN=3M2cGw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CABgObfaDAhrpnVqQaKgG6uxPQe1YDu77YOsUEx9nqrN=3M2cGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5NyBTYWx0ZWRfX//V1LdUi4FU1
 XtdZXabvEBwKwCehW4WvY5YbYikZI+w48pUKaZShPhONPYndbwzSttrt040cqSin/hNVlZQRN0Q
 bRnVPN9an+bXFc5pKJKpLIqzYwGxzzo=
X-Authority-Analysis: v=2.4 cv=VsITxe2n c=1 sm=1 tr=0 ts=6a84591c cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=KFLP8JxMXue_9hLRhRUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _tFu0jBE1BvycpqdXdRhFtMpD_OJ6LGK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5NyBTYWx0ZWRfX5FWTsGH/PN4L
 WhqbeWI1PuEo8iORxCeNS5221rHLCPh72ERZ2FSYhN7SRMjpSxFK3O5PBEorop66A8JvQIEt7kb
 tjQ4uK4k5HIpI5CGsA9SfjtUnuXGex0nBTDlYgahZNg/GhDLShqlbjiQbBHirg25QCZcfykiOZl
 SVw3ud3E1zsPunZBnECJd6jfliMlXdtwjQLq14UoYCz5e8kwXIf88fFlvyffV2pK4zzX4PQtp+5
 CLVtwdELsF3pBUrr4/klJAHXSvmBmzh1dLG2QXhqM6znWKJNcFeVpOAASmorXK68W7k1vmA7cjv
 8AqXMODFdMZT4T2GbWlPIZI1coWcvCOKb+uPbtLsExyx/RW50v8iJiROegwEeUJKW+/lwLoRUDN
 vEjauQTIQecmw6ln/r+14KXh9FVeiDCYOOnfLy+rK/kmfJFnHeOHj+GL+742Jby6oT0JqorEBg2
 61YeYzjTYMghFOPY/1g==
X-Proofpoint-GUID: _tFu0jBE1BvycpqdXdRhFtMpD_OJ6LGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180097
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

On 18/8/26 12:30, Paolo Bonzini wrote:
> On Tue, Aug 18, 2026 at 11:24 AM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>> Your patch is correct because, even if cpu_thread_is_idle() sees cpu-
>>>   >halted == false, the flag could become true during
>>> process_queued_cpu_work() because it releases the BQL.
>>>
>>> However, I think the better fix is to remove the return code, and check
>>> cpu->halted in kvm_cpu_exec().
>>
>> Looking at it, even better would be to move *process_async_events()
>> from inner loop to outer loop for all accelerators. For HW accels it
>> seems quite trivial; for TCG I need to figure if it is safe to call
>> icount_prepare_for_run() with the BQL taken, due to the replay_mutex
>> uses -- here the win is cpu_handle_halt() ends restricted to system
>> and we can remove the odd EXCP_HLT handling in user emulation.
> 
> Makes sense, but probably it would be a series of its own. :)

Good, right.

(FYI the motivation behind these cleanups and documentation is to
get hybrid-acceleration, so a consistent vcpu_thread_routine between
accelerators:
https://lore.kernel.org/qemu-devel/20250620172751.94231-10-philmd@linaro.org/)

