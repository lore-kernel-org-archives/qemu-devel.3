Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E73CA100D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIHQ-0007HN-LN; Tue, 02 Sep 2025 00:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIH5-00075G-EQ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:05:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIH3-0007GC-0I
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:05:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SASO015364
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ipDm1e5nw1apgo+50RgPBPg+++LforSnU5Bsed6rCz8=; b=nj4SVDrDg4WoeX3q
 s66mt6Cj+1CvHA0bbqw8GtSDQtMEe03LnqGND+IzsjDBxrgHol/jnBCdJPtXPk9I
 Nu4YYAeLWsC/GPr0GfhYWlCL7hMA5C5dzbZ/Ui3qtG8mvTGqDiLv0O6pFp7HIIx3
 eV5SxEIYHp7K8sDVe3F6KEqZGGZ9gPcSzvw+W61pBGfm3UQe7PMId1+2WxcGGtM1
 yINEM9BdToMmOtqwE+2HaA2ivm+r8lm3rEQl4+uaTaKcEb/mJc9kdelS2qBVYuP8
 zwUI1uozipzoF0udL8n1Ps/UlmjUQZTMhVzoFQ0VlQRtfcK97Un9NFv0d8vX7x07
 55b1TA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxep3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:05:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b4c1aefa8b7so4019981a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785935; x=1757390735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ipDm1e5nw1apgo+50RgPBPg+++LforSnU5Bsed6rCz8=;
 b=kmJBBUwOaBjNDURPL+gVoxCqhovBmt8MqKEUh5NQDUqfywrfHCHIOS7Zl9xRQDKIB4
 KeP3Tg0Z0oluf6YiQcWEOe4aqc2HxyTOzjcNEvobYTo2bmSAkG0xVsFChkaer74xHgJn
 EKHEFAMJJ6uCRgzY5DX7hRD1x7l5BwLYDwXr8I394vlRaLv4+uXgD6azoEN8uovKhxxu
 nmA9CCB54lzDnwvToeqj4NOfPuknnuyD0B9gs3rlmu9EDBykzD3WY0qEv054mtHXbBXV
 6jgTxNRtXoCG1XE2CXLy4ApIRhLnT9YcvL1kWBMmzRnhsFpo6T2YRFdgy6Q5m4m2llVr
 Pm5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTUYe1KRdomh0ZAso+dQViED/swjvd8fScgVzCEr3aN0Ay+c5//OUS1bs+lIYO+sFMJqrIbKwAnZcI@nongnu.org
X-Gm-Message-State: AOJu0YyetbolzUNudX0tDkcOTQCZvAB+FtHlfc4BkIjw1Wm5yQKzEIh6
 JQNP/EBCCcgCOP55sxaKHEtHL1oUSQA/p7pumR49BgaMGkEE/eqFO6RSCGkXOt/zAb1BecMLOWv
 qkOWl6iOqHzdK7pj/Ln8961ZLh7JD3IYnKCrBPThppdQZkyyiq7+xB27P4A==
X-Gm-Gg: ASbGnctA9q/QJs945JV/IyoeQYdDRE6XmO5JGcfsW9III+qgYmGuegmizTXSDww3XWO
 Dp1oAo+p2R01l8VyyaOmowzFe0o5tsYYugKP/mbfv3ShTtvsgo20f1bM6b6+flYCFKBCOFTvcZN
 mx3MOI1rrt0sy97bf4VouCjhjl/RqoFuSPGxZBimTP0Yj3gRSieowtPC8o0202V5cKzrCSOqMqU
 ObWRSXcEH+BnkVLF1BLTV27CzKaKvPixbx1w/FLPT8/Z9PlQDzYmHdF1wuuYLZEFhLZL2cYINdT
 JL3+rAY1Xriq7WwEg7jsE9WieNOo8t5EXMBSOlBw7Odjl2s4miF22zreVgRzDQ==
X-Received: by 2002:a17:902:f64c:b0:248:fc2d:3a2a with SMTP id
 d9443c01a7336-24944b6cf13mr135344255ad.56.1756785934727; 
 Mon, 01 Sep 2025 21:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUk+G3yQSbOSH8adIqzPJCLklk9Rh/YdjqLTkK3iBavhb/THPu6aSBiTl824uzM9ms/AGe6w==
X-Received: by 2002:a17:902:f64c:b0:248:fc2d:3a2a with SMTP id
 d9443c01a7336-24944b6cf13mr135343875ad.56.1756785934251; 
 Mon, 01 Sep 2025 21:05:34 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm119538555ad.45.2025.09.01.21.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:05:33 -0700 (PDT)
Message-ID: <aeda5ee0-da2a-4a49-b9cd-e84fb5a7cd95@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:22:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/38] target/hexagon: Add hex_interrupts support
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>, 'Michael Lambert' <mlambert@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-39-brian.cain@oss.qualcomm.com>
 <011b01db9374$b8982630$29c87290$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <011b01db9374$b8982630$29c87290$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TYXt0EX7FuNifvakUBJ4oVRbjEUmygVO
X-Proofpoint-ORIG-GUID: TYXt0EX7FuNifvakUBJ4oVRbjEUmygVO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX3TUdR1wwINl/
 4a7w+0Fmkpr3MkSV8BBb4L5C7Fw7uh4CJK9RAc4UCds7uXUgAKWDPHSBdFZ5t8dLy0FavIKv7O9
 5WBvEIRnA5mix2Bxnq4VE2EroaPacEvFUWpty94lUsmkn8t/LJOTB9QAMAj3GKChn+7D+YLPxuo
 2FMN3fVxhjVV5/ZutI3CjaQo9QJIsuwgOfOyC0Pzdmn+U/nbW7tjz/KUaxD3m9GI4pJlrrOSwDy
 4LVDjcOqILIeENzYKlGmaPLydlG7bgf0DKNa/gL2TUw/VwnLgEi7qElZws43HnXPMnWCe0X7re2
 Zvce9NDXUuN0+Ig0FSoAE5sgSdHFcJYObOiCz0zi4oaWZu2X9/XCGCnzdUw/TFpdusg/CYf5X2U
 0fJ5E1IE
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b66d0f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=-0I2jZQW5GywFGCs9KsA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 3/12/2025 12:32 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:26 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>; Michael Lambert
>> <mlambert@quicinc.com>
>> Subject: [PATCH 38/38] target/hexagon: Add hex_interrupts support
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>> Co-authored-by: Sid Manning <sidneym@quicinc.com>
>> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>
>> diff --git a/target/hexagon/hex_interrupts.c
>> b/target/hexagon/hex_interrupts.c new file mode 100644 index
>> 0000000000..fd00bcfb9a
>
>> +bool hex_check_interrupts(CPUHexagonState *env) {
>> +    CPUState *cs = env_cpu(env);
>> +    bool int_handled = false;
>> +    bool ssr_ex = get_ssr_ex(env);
>> +    int max_ints = 32;
>> +    bool schedcfgen;
>> +
>> +    /* Early exit if nothing pending */
>> +    if (get_ipend(env) == 0) {
>> +        restore_state(env, false);
>> +        return false;
>> +    }
>> +
>> +    BQL_LOCK_GUARD();
>> +    /* Only check priorities when schedcfgen is set */
>> +    schedcfgen = get_schedcfgen(env);
>> +    for (int i = 0; i < max_ints; i++) {
>> +        if (!get_iad_bit(env, i) && get_ipend_bit(env, i)) {
>> +            qemu_log_mask(CPU_LOG_INT,
>> +                          "%s: thread[%d] pc = 0x%x found int %d\n", __func__,
>> +                          env->threadId, env->gpr[HEX_REG_PC], i);
> Don't use %d - use PRI* instead.  Several instances ...
>
I believe I have mitigated all of these in v2.
>

