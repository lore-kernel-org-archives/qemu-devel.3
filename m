Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DDAC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegzZ-00013s-An; Tue, 30 Jun 2026 18:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegzX-00013Z-Jq
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:31:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegzU-00086l-GF
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:31:42 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDYJ42948420
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TYzGI0g8G/f98sSVaqSMz4wn4ZGrU0FvoFMvD044VBY=; b=lZE/sCnVL5NgYKCx
 9QHPn20/XwVPiT2R+nD+AkWlRmCdbFsQMMVhcvpVRf/TuExwZ7/gCN+HJrVqfGqW
 KR/wSC/k7OctEtolEap+8nUjmNSNatLA0hgAJReMwfNrNRNKDuRfPJSKRFRUOnPO
 d+mR57fLJ5m6FpOGfTHtcDteZZUjU2qqtxmpq5ux+98IbsDN1eNTPPhxgBIQwa7j
 wzgYGE8S1+BoxdUjlm72VQNom6oohBjoULW3C/HAdO7oi9k6OIH8El9OMV90jx+7
 uQ2WOsYxmBBZczkGWnDAnFCKAp5fpNHu+z3VuwRHKhy2QMqs5ljSc9rCfZvKsvJn
 OC9Znw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw0sn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:31:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92b4b575561so286089385a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782858697; x=1783463497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TYzGI0g8G/f98sSVaqSMz4wn4ZGrU0FvoFMvD044VBY=;
 b=dN2RXyZFdvANho7WpIYmyNt2pUx5JxByuNVTvwD1N8ua41GH10Bj8nV1F25ca5h1kR
 FqzoIXeVvJLjSaCMFtni7m43hQ3HSnIKrvDQm4HuPrZXBWI4pMXbzGixi9yVjRjmoLv9
 uoNk9tDvJ/hhZ4ENDOIU4OXqUB9poyayIQfGjWIOSO2xOViJQuh1tX5KeZimmCwm+BAx
 MXsNRpjy8S28ysspaMl5DcruPBwdPsoQRfUZxMGfRz9M1VdTeuseA8rmnbITqFBQfaK2
 nVvmXQAsjxy3kl/I1aVraoLeZXX7O6R7wjsyE8LIcNjBf5dwrNVT7IOq+12fouNxsZr8
 K+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782858697; x=1783463497;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TYzGI0g8G/f98sSVaqSMz4wn4ZGrU0FvoFMvD044VBY=;
 b=Z/meSctg100hdKqxvVY5zYBzB6qUSaxbq72ctmWYyuZXfAbKBtQALqt66crid9bUBA
 s8ITDNJxwjsbfXbgvEyiXYI+dLH1dKNTjHuARYafXqx4Ixy+kdzO8s8BaAAmmB01pTt+
 YRdfpg6jzGt40JL7m0XE72xB4G5D/hQvNUuwb6nVZyPCY0EkoCosRFcFGDCTRaSpzzRt
 R6nGZffKJ+a6RFzQiEhvtNgg34ZUMSrcYA/3vWLzD3nOQMEcYb/je0R8/NJTws2fXLgG
 ZXBQKpPrhEkTfLXhBDuC6UYxOR868sToS1c2nMOyxcUOqubN0L1eJFtRKpKKVLgIYcWW
 bIAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CuSgdO6aq0SI0XniL2k8KOfry6gG9VB62SdMe/b1RznXGXbbdwRc8DsC6IytaNMg8zWyDNTxhUb9G@nongnu.org
X-Gm-Message-State: AOJu0YzlJhYWtnAWt+C3bsPA4YG54fFhr19NqRVJFUnvKo5c8/g71kN5
 pWzL9nRh7gnUUFQPxt72rBAWZl8wuI00y8sYwmzbkfv3lpy00jxtiuMyWss3OfoGE/JKxLHstZP
 tN2t0ORIC+8rBEbMTlJYJ9t75ZxiwkKK7H0DfhCaIdU4HcV1Vop4isavHTg==
X-Gm-Gg: AfdE7cli6R956oqt8DIhceQMuYGNOZFxdLBJcatr+tb73aGLwsZ2H1MjgrV3iSgJ9JL
 t7WL7OzrX6CEGEzrJwf6lrYq8POYjHBU/wCRhMue2D9Utye5ydwTATpSdgGd6rxM+cNPWmUuLOK
 OcbO24QfIgmR9nKvlfnWzdyqYWo3MYcj+EDhRZk0T5s+GP4UqlRzF6BKy0oBEvn+Xnx8jS4oRtq
 F4GiqdtmI/Fdgn4srgeTJTXHK2kH2qEROMDLVXhXhxzOVsitSwRHXe+JbYt3UzYZTP+TsjhCWtC
 T6C2coyUICtDLIxshtkkfXx/HPzg5FXogYl4J03ibEHfQNhtztpRvjgy2a4EjmqezIND4DBNZ9r
 CNfpeK1FOYolyqwGWuDRvtqixu01xwp3EM1ZLpdISQ4QrgwWieps6M6QvZy0eYQ==
X-Received: by 2002:a05:620a:6188:b0:92b:9401:7320 with SMTP id
 af79cd13be357-92e696af82cmr477695085a.2.1782858697067; 
 Tue, 30 Jun 2026 15:31:37 -0700 (PDT)
X-Received: by 2002:a05:620a:6188:b0:92b:9401:7320 with SMTP id
 af79cd13be357-92e696af82cmr477692185a.2.1782858696615; 
 Tue, 30 Jun 2026 15:31:36 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d19573sm10862980f8f.4.2026.06.30.15.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 15:31:35 -0700 (PDT)
Message-ID: <c790ec0d-0f7b-49c6-b588-7a82114a2b9f@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 00:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/loongarch: gen_xvreplve0: Fix elem0 offset
 calculation
Content-Language: en-US
To: shankerwangmiao@gmail.com, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>, b4-sent@kernel.org
References: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
 <20260701-loong64-be-v1-4-9c7d65e00697@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701-loong64-be-v1-4-9c7d65e00697@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a4443ca cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 6UHGGZCE9D___rwqgBpRRA9C8XSeV0Ua
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxOSBTYWx0ZWRfXxbe2EZHdtcDn
 /VZvwgk3SHdc8C/KpTMZLXnBgSzbDOAZEE7GGU8ZhPMdSF95s+p8jnCikBVU8oi+ar81oo/Fx6a
 1wxBB24QOxYPAtM2pg757OZGozvgks0=
X-Proofpoint-GUID: 6UHGGZCE9D___rwqgBpRRA9C8XSeV0Ua
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxOSBTYWx0ZWRfXzpj3TZQ2wDtO
 0HINVzZhO1eMoj17Pv6uVMrlGVqFw73kLy1Ibna1pdvQegfYhZ3Vnzr+I3Hu7b9axOk2mUWjrM1
 rIKcm9bkI0oEjp2+Jaewa3E3byat12PWfe1JZcn+BMu6ru5DFAPigFkm8E80YyhmpDn1DUXtxbH
 T1YOc7kUGu0Tg8nfld/jgmvi8VHJELDnmi5zvrFWK/yVW8VHmU8DSEHEQ4kiJp/NRoFWO0kGLrd
 TY8jbGsCM6lUM7kl3EObdtiz1nlq5e8/mFWc0llspsuuMajwywkLYG7ez4avVuEy39yA0blTEk6
 fCGBLZbImzWQAM1Y54TjCHdlPH2nh1GjJt9FKxkRKpxkR1+z0rq5IgY3LFUlOsB5SSq8HUjEXPt
 uwHGyP3w2PbB+9DMGFN+aR62Uj6KwQ02feVJkZ0+KS3dE3gg6/yDPAVUNJHmiKI8wugvzMGO0SR
 OYN9X5J+GpjjPmdJMVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300219
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

On 1/7/26 00:15, Miao Wang via B4 Relay wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> When xvreplve0 is implemented, it should not be taken for granted that
> the first element of a vector register is at the starting point of the
> vector register on big endian hosts, vec_reg_offset() is used to fix
> this.
> 
> Fixes: df97f3380760 ("target/loongarch: Implement xvreplve xvinsve0 xvpickve")
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

