Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E76CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI5C-0005jG-VE; Mon, 01 Sep 2025 23:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI5A-0005Zm-U1
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:53:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI58-0005G4-TB
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:53:20 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S5ds021595
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3qeCLnaewpy0JF0nlGpTO/CsTw+EHp0eW4Ic3uZJCVY=; b=nWNL045kNS5sRbF/
 q59Wu6i0qXM7NcbJI8VNDvUX1HQbuOr9T+RQitLZna9unVtd/NkDPmrVvwk26KsS
 cQMnG5pyvlCTNhbWO1C2HO+VqkWTm3GY7ZSWXuse2HjFOt5OJO+S4/p8a6Jb49w7
 k2Dwdv4beH8ut+ni3SFPU3hXr4UYgu7vvqLr2UFFG2/5vWwZZIQktaAeBQ/5jpHp
 yzDQnT9YEjK3JEK7cnDr9M20w3hsbW/vAOwmYFX8jWtg5qs/Y56ZuG10/VZVyezw
 KzhHaoE/bLosOULoNYoDNSSq23jHEIJatdZwKhMxjJ8FEMhQ5Q+IPIUpDjtLmjDC
 j1MRPg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8rxffd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:53:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24a8dcb3bddso27601005ad.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785196; x=1757389996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3qeCLnaewpy0JF0nlGpTO/CsTw+EHp0eW4Ic3uZJCVY=;
 b=lVA3vzlqzVD1z/lVj6vlSCCi82B54y8FSTPOjMlbmzItzZwlVX3ZhHfjiufaC8cJEh
 iszAOkEF4apIiZhfnM5RLlj56rLxhmURgyRI2Ob3wPhwdNUk2kRTVLEfK9kKy6/o7hxx
 OaBxGpnQO1ZRIZShjw1nEWrctBmQt92Q5bY2Gq4vyZ/7hkuZ1TOnGa92lyngnpdeiS5w
 FjsH5CM5EFUj6pA5xK/Ub2/yY9yuSZJQBVNOzOlqZojplzF6WBgdGdBBpxtYP/b+BSOu
 U1k+45MIoWl4Y5ro642jHUkQewCUtEsGvt2zurGbFSAe/kfc+iCN+7uO9A46t5u0/GRN
 f4NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfjSY8yAfpp+loqVpP5w7+LKLXPn6tIO2fPyNHDQAyaphbZFLzIzPVbAt/Q559E79njhReDjcA0t/t@nongnu.org
X-Gm-Message-State: AOJu0YzL/ywD6mk1ZuP+TcTy7x7gGHP+jpw4W5X4zfqvVxdSKJ94lVc7
 mapdzY6NnlW9QCOmwO0INx7RxC1ic5r6GBmK7VljTLu6qkYm1E5fU/hNjXwF1Mqx/GxLVrA5jdM
 PIbg7Ge3yXBk3Y9l0nVjWQR8fBjlR+lBxALiQwceyjHapvvfK+rsOoySDIA==
X-Gm-Gg: ASbGncuLwTUI4eH8BFoFmxCLxpQy2Zuet6iXl+oX4NwVYwfv69unWAn7Sk357sz1ohT
 3sP6f4xPOVP1F9lHEuhu7ethSmNNbl4a7w7vH5/i7NryvDznTkj/RCnhXICg7uWJzBGDl5E3crD
 JhNQwXbFlVslo7Ay1ai1MPQHzZjUjOpS3WDwiVl2sMM3V1b+eogdrj2qezPo0qF7OEfz7Bss0YB
 Fgt8qg/QIZaclyKd2DKDc/YD2uvAisKd1JwNNKEbrAzL+BlHdYJhwKiNQ2xxTg56g8V5948nKIy
 gDSPPbq9Ce03sNjQm6WkYJlKi+UjqHg+iIBgAsTeVByNRUXOKSBaRUHAlpp3hw==
X-Received: by 2002:a17:902:ebd1:b0:246:9e32:e83a with SMTP id
 d9443c01a7336-24944af3220mr135190235ad.47.1756785196519; 
 Mon, 01 Sep 2025 20:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9RDhyzwKcPd0nagIOqyDxYNwI8DWuMqc6gCHCMtItOrW3N5L5G+yXAdBF50axoW5tVspZrw==
X-Received: by 2002:a17:902:ebd1:b0:246:9e32:e83a with SMTP id
 d9443c01a7336-24944af3220mr135189885ad.47.1756785195964; 
 Mon, 01 Sep 2025 20:53:15 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm119295495ad.45.2025.09.01.20.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:53:15 -0700 (PDT)
Message-ID: <0ed9bc1f-1e9d-4dc5-80b3-90f1c51da08d@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:40:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/38] target/hexagon: Add handlers for guest/sysreg r/w
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-16-brian.cain@oss.qualcomm.com>
 <029601db8f99$b0267440$10735cc0$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <029601db8f99$b0267440$10735cc0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX9f3eGXPMK8uW
 rC0tZguVn1mwWFME05URfJRUKC0Rn72ALq9KLLTwbgc41/h3jKaGHJ3k47X0InL7f/Aic8qa0Fy
 GPf+u0W0+O1yNogHrdMo/VYe/ldmvXQpSqCHRlQScXvGck8LuzEyoqfUfy2bLIlQRhB/4QnI0By
 NKuHwqyLZyIvaIswO2G+dv7M8p5pkrrQ5BPfxZ8vxqUBB7MMPj7jVXonIr/nZAXKy6n0Gphe0xD
 o2l5Vj0FwpRyWCikfa/FUNxel2Ac6WYN+Ta01jg6C080pk0bIP09dohBjwYYZ3BVKCtSSjVlRgp
 ljku3/c28S2mNGJ65xjfQUVTTOhdOTj/aprp0Cjxbd5dMDI5HduFphT8ugpeZacLlIekMGfqUNy
 pV8z7Ihw
X-Proofpoint-GUID: 1cd1M3ZHiDflezqY9zakFg-UXxqdgaXu
X-Proofpoint-ORIG-GUID: 1cd1M3ZHiDflezqY9zakFg-UXxqdgaXu
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b66a2d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=n_Hw8APGRrwVRHwZlUMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/7/2025 1:46 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:26 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 15/38] target/hexagon: Add handlers for guest/sysreg r/w
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> This commit provides handlers to generate TCG for guest and system register
>> reads and writes.  They will be leveraged by a future commit.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/genptr.c | 159
>> ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 159 insertions(+)
>>
>> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c index
>> 2c5e15cfcf..488d0b4b97 100644
>> --- a/target/hexagon/genptr.c
>> +++ b/target/hexagon/genptr.c
>> +G_GNUC_UNUSED
>> +static void gen_read_greg(TCGv dst, int reg_num) {
>> +    gen_helper_greg_read(dst, tcg_env, tcg_constant_tl(reg_num)); }
>> +
>> +G_GNUC_UNUSED
>> +static void gen_read_greg_pair(TCGv_i64 dst, int reg_num) {
>> +    gen_helper_greg_read_pair(dst, tcg_env, tcg_constant_tl(reg_num));
>> +} #endif
>> +
>> +
> This will work, but G'regs 0:3 could be read more efficiently by reading from TCGv hex_greg rather than calling the helper.

Some guest registers have special behavior, so we pessimistically 
generate helper calls for all of them.  Should we revisit this for v3 in 
order to get optimal codegen for the simple registers, or can we revisit 
it after the series lands?


>
> Otherwise
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>
>

