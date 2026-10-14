Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B713DCC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4dp-0003E4-4c; Wed, 14 Oct 2026 15:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH4dn-0003DY-9n
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:27:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH4dl-0008IR-BR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:27:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEb6os1013288
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cQmfXwffK4c8R+nazP/xG7jjag1cGbqdVU++1A58E0Y=; b=je1rzL4OHb+gQN0A
 oP46R0IUX+W7V5Lx/fynkMTZGU5x4n+Tu2Yx8X43Ca2jJd11/NpZYb0adfnVH2i8
 cZmMU1/Z7Px/uzwTI+9oXbIRJtenILVTC/J3vuYt0EoyLyjrA2F73JzJvA8ga1Ad
 8VKS93EuNiWp6PEJ1P0EOlHM0gpSI0xN0RW74cmRMoBp+kvE8PONhTPQm3w4a4SZ
 R38x77QxQiwG6BaOCsRkuxKD0dVEz3rAfEY+EShwb5NIyReM/dq5Nh1Rmv5xomqc
 +1WW63ZZ2sIlpeEaGpmN/De5WLSELRzvPi1PYIprX3f6JPQTpRso3seVBbXOt/43
 OGLLbg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80ct3gq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:27:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5351f1b26e6so67071891cf.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792006070; x=1792610870; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cQmfXwffK4c8R+nazP/xG7jjag1cGbqdVU++1A58E0Y=;
 b=CLl/fpoWfztpUUe5EfEfwGw5ofTtC4FC9lx73STknXOjgzj6717reTazliDfYwRdp1
 QGkcb+lYYojR4LN9RTrSlUPuyB8RcaQdS1HpBj+VF24W93wk0p5upcFRvN8JsebQhC83
 D0YJ4gTZKgUIeoeXJr842or99nr7eDy69d+Vgfy8OPnM+8pk2mqqbt5P2CQdd5oygkwp
 Gt90nxCLeJ7rT/Fr37UnsOcYbfH1ntAAxmtV23XyMx0DCz73Ag1LmMDemaCzJjyb5ymC
 b+8UDQj+yKeDmuqUG9oP9xYh8z/sHnsZdzAgrAXN4EvfA7lIHuGfjTk9C4rxKG3fax6z
 k+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792006070; x=1792610870;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cQmfXwffK4c8R+nazP/xG7jjag1cGbqdVU++1A58E0Y=;
 b=QDLrXKy3sOjCEpNTsS1V2b0RaYt5S1qm1+Ky3Y9NretRZLsnqbFtEa8M0rchLOl5eV
 ZmTWjmaYmOiLoYIsRWUcmrFV1wz8VrE+EsmCfWJMi9Bbx3ySGzAFf9i8cenVuPCmjt7a
 v4+xJAujrPptllzwMIJVcmrQnzsf74CJ1e/afCGVeMTPVSo+sq7d20UHGkKyzr3AKWjX
 A7dO0g39DM+pK9msw7ZXM86bv7xmvJT0YJN44Rx2dJ391Md23Y2bsI6fs1mP3hwN3JPx
 scoicMCIi1oW/W0f4uTPIAroQ1iHop7v5/TsW+wpbTnKXuZdDJvApYofG6zXdsum0byl
 Thhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7eQpGNgg78CvpLlUfNbETHwAQLR1kQ6GIDii+aKVGzEAN7VMpx4P1BEs3f7dnL3ayA1IQJUeLFpzt@nongnu.org
X-Gm-Message-State: AFq9FYIgicxV1QGm5WtEKflnnlvIk19OdA9VPmed+JKI4OW6WdaC4KiL
 kXlV1+QBP2h2X6/6R2klCc9lXbywj+nERXP2nN4vbrWQEafdE/MsxCUn5PWK1pYA5OrjEOkpFo6
 pqPONGmEi2BATRgXL9AQFibcCTrTiwqc9x3zkKuSicIA6moo34krlv0lLfw==
X-Gm-Gg: AYBFou3mhVFrhZi1qo3z7/gGSQDdQiGe6wl9r/A4lBKVw6J+yNA95TUKLruQ72AbNue
 yNmEfu6JTsXm4oPdJs8ht2rJcfdOV/GM2/doujep/fwCTGAZXNG9Lh/wC8TXt/Sq7Ca/ox0SwSM
 ZdoXiYqHnxSMPpWTLyueT2Df7NTJfk1Xju0Dd5QvgJ4+N7jNDk1/IIU2i8uDr79ybFDcOsJZJrn
 QsEEqc8XPEfipoA4jeIw50Qxn+OSF6aa4mhcsfLzQubA2S5Gu7mOEnjMoDZ9Te6Doo+YcIrcXC4
 KczgvJET8xqvvkXdwnAZdtsiRh7NeVo0MB4aaz8Vo+EP/1qsAV5h8pXMCUxc59iOe+nStTOmB5o
 WdtUxUfqkbz6pflyzZUmdcDflW8c0nllfoYW0iF6gsvSc0HFF2bMTonZbcejFdEt5
X-Received: by 2002:a05:622a:987:b0:533:998c:eb09 with SMTP id
 d75a77b69052e-5359f498f4dmr265116051cf.2.1792006070162; 
 Wed, 14 Oct 2026 12:27:50 -0700 (PDT)
X-Received: by 2002:a05:622a:987:b0:533:998c:eb09 with SMTP id
 d75a77b69052e-5359f498f4dmr265115731cf.2.1792006069664; 
 Wed, 14 Oct 2026 12:27:49 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536127b29desm4824741cf.11.2026.10.14.12.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 12:27:48 -0700 (PDT)
Message-ID: <6fac4b96-7059-469a-8f07-106eb2d06d58@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 14:27:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hexagon: mark clock-backed register reads as
 I/O
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009003521.2227155-1-brian.cain@oss.qualcomm.com>
 <20261009003521.2227155-3-brian.cain@oss.qualcomm.com>
 <c7c38763-5cb7-4e4a-b841-5e52b1800b70@oss.qualcomm.com>
 <5a222b51-4475-4301-8e80-a74320329a3f@oss.qualcomm.com>
 <6d139637-ad42-4429-a405-eea8f384c684@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <6d139637-ad42-4429-a405-eea8f384c684@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3NyBTYWx0ZWRfXye7ZbBzjzdT7
 Mr9U664UdfOr/0Tg6XLJslw7Pr30KKOWxqjWQG34tLxTd1VQC+jDUe/ijHYawyDRHUoRs/N+PF2
 LBlWB2al3AUxVWogQw326q2g8KapHmU=
X-Proofpoint-GUID: BzkjRs6tUcTnE2ALl4ofgpgV545eC1IK
X-Proofpoint-ORIG-GUID: BzkjRs6tUcTnE2ALl4ofgpgV545eC1IK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3NyBTYWx0ZWRfX40BhRF3Ng+OT
 8X5Ogsl014Ii8knfUExRoe1r2HpwTaCGuokoZUt7ofQV5+bwstE/KpfOV4Yn64ra0e9gzlx8pUi
 7GW0X+LA7g2pIxf1c3TgSKbanH9AYEVFTofD1WVJx2svjZeY80YqdUf7H7l7gvPR0mJ4gSTp/Xx
 T52xm49IwbKjt1jTMnW7RPWD3xv6m8xwpEn1+guifk0nO+7CbG08q2VgoWg5jSaP3ZRt4ot15HP
 VfZXSmuF2fu0JkHtN65niteGGqdwa/q5GPpirPDLoBMZBHDP63ouDBHbiAlQoCG8wtXpACjDM3x
 PGftjdoheBpKYYpC0mwsjr6LUg4fFCrqYsUDf/iTc4hA7e27g4nImMvCBQqqnRjwU/Koyhi1eP8
 Yld2lUM8v+EWV4PS9/cfWkBU3ptJTzVCYBSfvMLvx/QfOwPlDN52UjyBqNwioPCk2UEuPWkwUG8
 CfH0iuk5nzIroxMPRoA==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6acfd7b6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=YqcXMpZKe_wlU9nqQt0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/14/2026 12:18 PM, Pierrick Bouvier wrote:
> On 10/13/2026 9:16 PM, Brian Cain wrote:
>> On 10/13/2026 5:10 PM, Pierrick Bouvier wrote:
>>> On 10/8/2026 5:35 PM, Brian Cain wrote:
>>>> Mark scalar and pair reads of *PCYCLE* regs as I/O so icount
>>>> synchronizes
>>>> before reading.
>>>>
>>>> Cover the read paths of {U,G}{PCYCLE,TIMER}{LO,HI,} registers.
>>>>
>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> ---
>>>>    target/hexagon/gen_tcg_sys.h | 12 ++++++++++--
>>>>    target/hexagon/genptr.c      | 30 ++++++++++++++++++++++++++----
>>>>    target/hexagon/hex_common.py |  8 ++++----
>>>>    3 files changed, 40 insertions(+), 10 deletions(-)
>>>>
>>> The comment on translator_io_start seems to be out of date.
>>> cpu->can_do_io will always be set transitively, and not only for icount.
>>> If I understand correctly, calling translator_io_start will simply for
>>> effect to end current TB, and start a new one.
>>>
>>> All that to say that I'm not sure it's needed.
>>> Did you find an issue without this?
>> IIRC without this change we get a "Bad icount read" when performing the
>> I/O side effects of instructions like reading from the cycle/timer
>> registers.
>>
> Fair enough.
> Indeed, other arch use the same mechanism for such kind of registers.
> I'm not sure about all the details, but makes sense to do the same.

Oh - err, oops - but after looking closer, I did incorrectly apply some 
of these to instructions that don't trigger I/O.  I'll remove changes 
from those (start/stop/wait/resume) in v2.



