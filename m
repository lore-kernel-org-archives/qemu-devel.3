Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9702C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtW9A-0007YF-2g; Mon, 10 Aug 2026 15:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wtW94-0007XO-9n
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 15:58:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wtW92-0004fr-Lb
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 15:58:49 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AJm59i2547546
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 19:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vqSNyeCFDo8WfgTt3CwGG29rapyrhzvqXd/wxh6OrPk=; b=MNwYuXaxJIjfGGEX
 07uX6KectY8r3XXFBUYnG32fL8RcnCeLpFb8iITgYfXutKbhDiFBfvmgb8eX7Kx8
 h0zmNOB2mJnNgrKPfw2DJgH19Vd1wUdxTRhAngFIbEgaPKdsV/MIpKw8prVoDvwq
 TMbnPyC6CPH/wIOMXcvVVLTMdqZMR6nmN8JQlf7giQwPeWgP1PTWEGJes1PPcCI9
 yvbfmBIc3B9fhzglSQ6ax1nz4Zd9pITJOBSyzxwUEeNaRJsIU7/ZFhOrxvKaoSjh
 /usAFcrik71KkedtHDFSupvfVrsxJEML5ffJza2mfZU/9N0XYtUlB7Ehs8csuB8s
 K5foDQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjv0rtq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 19:58:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so33891185a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 12:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786391925; x=1786996725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vqSNyeCFDo8WfgTt3CwGG29rapyrhzvqXd/wxh6OrPk=;
 b=dC74yYmUIMgQmBIU6HQYMLCkYQF5l1fTE7TfWTaSg/kzuUihvY8bdWX4iZvmsO6wR5
 c/trYuMbD403VYxYHXVyRr6ko/0Fvhqq/MtxLFKNZC/VlZPxXBERvyjFncy1UH2IuiKP
 MXikY01JIGhSe6JN/bWX5B15xiWL2WEAht12ySdQdg504lzTGMD93Z2Lwg+SQpmsw8jO
 Wt2j8rC23Py9WLchVJJL7ohdVNd8G1LiII5EGGgmXxHjBXApjsUtdo+kgMXspnwfKRl7
 mIzVXGCA/0elq/bbj77aWOt7O+9CIGeNsYW/EQWHVxJusUEkb8UKT1vxAYbCa2UnCIaz
 YVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786391925; x=1786996725;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vqSNyeCFDo8WfgTt3CwGG29rapyrhzvqXd/wxh6OrPk=;
 b=eBGiqzZH1u2QFFHh4dxoAen0GMytCAGM2EbgDf7dH0EH4mm/KLQ4vCwNrKmsVHRagL
 RjPQJ+LwEbO2gmWeQ01HyRsp4pw/j0vsc5oKV/Kgfi9M5UYqvWXmom7VQO8U4hn4phMP
 WfGU2C+Ek3GFlis8KwVk+BOCGwMvUXV6DbTtoLdG1+kQE34/YgfKOues4CUNykzOtawQ
 szYBK8F2qm10gW+DA0ZYCZviHtH07I0jQLRcdShBNn47NIpiHVBWKk8LsAQeBVd4XCFa
 /fMCs1/dRTf7lF4ItSt5s1Mq1kxLNWz74jKNSQjPD8E2AWx7gP2p5AYkcdUVCF7i964f
 XlpQ==
X-Gm-Message-State: AOJu0YwI6M/c61N8sBQDRbVsK/oU5T2WlOtfIpZdruxknVpooxc2fbza
 0+QObJUPlc/grN4Z0MXTOxvtHfrosVzzGm2wrW2tIjZ7DZQbLvg2fmwIx0bPRUCAv/v0coEvxXY
 4Dwr/+R4FON8yrzoIko+sZPA5kklAz1Oc2SVyZJbMrhpgxhtAsSATXTkQ8Q==
X-Gm-Gg: AR+sD11pgQOJu3IKd/oOfjj39SteMVUMSWdaTjgts2m39RMQ+ZgcEnz6bN2p1dij95T
 JEgR020OZjDLeQui8D6X/skt2iNN3vhdHWLN073ZAOZdY0CDpjGbdTzEgKrWu1x7FopEmcAIZ7l
 QzNy+llr2HFqcaIqUfY+HeIAjA8bUXOY3J21aCayVEzfTVGom1qxpsjEubSR/oZnqQW41fUSIPM
 I+VOerWZWAAyNxXgdjhJT9KJWLq7CoJtTUE1L7xTSaD9yeLhwov/khSvg3v4gnSAfYVDlGh9uZF
 5CGmxFxEmuLwG1U4L7AkNfanUrCtpvSMQIsKJRNr6OJOn25K78hnQMnbIBHQpw0ooECnwo9GhiD
 NItDIHTNvnymNYBOzD4o7S0hdE7j1f2mb6Zxm
X-Received: by 2002:a05:620a:172a:b0:936:78c8:91f3 with SMTP id
 af79cd13be357-936a245d9f4mr117753785a.11.1786391924787; 
 Mon, 10 Aug 2026 12:58:44 -0700 (PDT)
X-Received: by 2002:a05:620a:172a:b0:936:78c8:91f3 with SMTP id
 af79cd13be357-936a245d9f4mr117748685a.11.1786391924370; 
 Mon, 10 Aug 2026 12:58:44 -0700 (PDT)
Received: from [192.168.68.100] ([177.198.100.18])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e07b6basm856223385a.11.2026.08.10.12.58.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 12:58:43 -0700 (PDT)
Message-ID: <2165dadc-6cfd-4390-b160-6a86bc86be2c@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 16:58:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/misc: Add Tenstorrent Atlantis PRCM model
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260729-atlantis_prcm-v1-0-502882933e51@oss.tenstorrent.com>
 <20260729-atlantis_prcm-v1-1-502882933e51@oss.tenstorrent.com>
 <6e689892-7a9a-473e-aaa7-6d50c5c0c969@oss.qualcomm.com>
 <CAEev2e94WKz0=jG4u+L77_q2ES+Cie_kOTc0iqB00hzgfi6A0Q@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAEev2e94WKz0=jG4u+L77_q2ES+Cie_kOTc0iqB00hzgfi6A0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2OSBTYWx0ZWRfXwVBhcOed62RD
 Dh2vhFlOP71QnuPd5oZJ23rAowwWwbeAaBYb3+vVKgYmqy/8OYgx1c9ndAIBfaaSfnoBPC9a3bI
 vLXqoKX2w2VoB1BRDSV3dGer1XJKoHqEFaum3K87bUba5ZduLTlsYXwHSGi8jpSwY03FUPXblPF
 zw0xkHKdeNaKk86hK3mNXj/C55Qou3anxbIcejyuS20OT2kHNTuN/eecxb2OQ4Ps/RK0hkUjWrl
 IUtd8NLX08twHk8dC+9a/Bw4QEiwfsoxEdk8v0tQWcP9I94cIhBvRCBYbYrmpng4de5u0KahByU
 KkfVlUf6Wm/NwvrH+TdA/jDY8ZjS19/0vJMDVqoTGKYDEDCrbygAIX+Oy9zAzn/R8riyIS5W4P7
 zeW5jdrefGKdj3s2OKP3OuoPXhSNTjg0siOX2nVTlCnA7tF60TEJTqfzfekoMMV7A+szGod8LDT
 DuvcrmYdhcvPLWbtPKA==
X-Proofpoint-ORIG-GUID: pRmVRhnfZzJ3YJua5lMIQW54RHXpOw6N
X-Authority-Analysis: v=2.4 cv=KLtqylFo c=1 sm=1 tr=0 ts=6a7a2d75 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=el0UrXJS4K3zujXh0Vdy/w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=5B5Qesa8auakVz8hfksA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: pRmVRhnfZzJ3YJua5lMIQW54RHXpOw6N
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2OSBTYWx0ZWRfX+cRyi6aQJTl2
 Pr5ozRaKIKBL1oe7MonH91EeygdlM5IU6XLrUxxIFLM2KlNLoIoVH8ItLZYy2cKd66kcpMuVVYa
 KLKcDZqFwJxdMb5HZGaeQvDijI/kmb4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100169
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 8/10/2026 4:35 PM, Anirudh Srinivasan wrote:
> Hi Daniel,
> 
> On Fri, Aug 7, 2026 at 8:38 AM Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:


[...]


> 
> I ended up getting 2 replies from you to this mail. Not sure if this
> was a bug or not. I have replied to the 2nd one.


That's my fault.  My Thunderbird had a tantrum and I re-send the same
message thinking the first one wasn't delivered.


Thanks,
Daniel


