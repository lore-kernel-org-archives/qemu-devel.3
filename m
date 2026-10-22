Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF0606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EX04zLIy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ta70RFZf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJsk1-0000QS-NH; Thu, 22 Oct 2026 09:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJsk0-0000Py-EW
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:21:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJsjx-0001Fg-1P
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:21:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MD3aqM271943
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SHNdxMOxnSiQcm4yc/nmyMkIS38ADqQafLfwxFtiMyw=; b=EX04zLIyYAyZR8AK
 9hYm6Q1NXlPm+JSZ+ffFGTXJmHQXNgZLcGsgB2H+iDc/9X6a5BsKbjPinAAGkNyP
 ZHPzKw4E/9ebauBjxyrGYlyAjhga34eOGH1D7Kf3maHTmLpEhtuYcftf2fjLJnjQ
 1H2iAASCk7ModJU97Rf8cL2Ru4pS8ehRg90myqxplpCTfDJOXDsXCq6iZyNHc185
 1QG1ZAKBK3nmbrvKR1sPzx1oGp8hD9fgi1hUW3I5Qur6TKfmJc6LYGjl7+N8Iw//
 8DHNeqzHOKEhkNz5pMvFf0RZ5BV5+ecHacDkW+f8ZTa5T58D9un5VQ3V6/tE+oSc
 bFcoAg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93cbp02-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:21:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1e62510cso445797985a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792675310; x=1793280110; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SHNdxMOxnSiQcm4yc/nmyMkIS38ADqQafLfwxFtiMyw=;
 b=Ta70RFZfmhCHIlcKN4qEuRkG67q/8Blr8lqgk3VOjq0hNvc7MqqTznDjiDyuqIGQYM
 17VsEha68Ub3jwWj+uCHpXJ78sbDIwPzMFLXn6qu58ze7KUoNOSm3kh3EVj308HkaKx+
 rP2+m4mwyhU6c+yH9ldhbPU/GYDETgKyWzBjygZIFMu5bcE09Eq1LMttlEWT2wMZYVfa
 DNmEx+FEQd4VA/P6CTYIOVrcS6WnYa7Ca495z3icOLQfbPEjajWoF/1ST1GwqY87ziPz
 tRWLWW4Hl5zru5yumTOpj2AIzm4aTokg7G4af6TSFgVLc2yBNij0xa5OK8HAi/wuj4tz
 4zAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675310; x=1793280110;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SHNdxMOxnSiQcm4yc/nmyMkIS38ADqQafLfwxFtiMyw=;
 b=GKiUnZ8U4qsoGjesuufFsRtwgOP+ibctgdYtbZvaBznvplJDbKPqA6C3lJkGdqbyW+
 28Krp0OmC6aBL0Fu4IDJkUMnYXbVikym/D9KwzEIsImQBcXswX3xO1v3tfvR5UBypgOq
 8ktW1c1zRp33OSQKboXARKGvapY3oUsJhRC+PjVliIg4GkQP92fxL5F6B/OPalZD5HoN
 lFTyBtLtjFbvz8005njAvq0BYeTps8ZyPrkwNJ28pWBd4Co2NQZW27MzUHvvzJZ+qLT6
 7kA1D4Ja2tOJUZgvlRgWAu5U00ZvK9LVAwXpK6TWaNIYRky14my+wl8YyChwglH9X3Bz
 rdNQ==
X-Gm-Message-State: AFq9FYLLjnK+TFcB9x9jfzhZr2ooRlLe3xPbP2A2cdMClOCH9rnnPpA4
 3JETnu5XSMxeSqVCy9aAp2X1XLDylmy3hSUkQwU+3T8pk53S6M50Oq+SWxvbUukWkTiwy2Di2If
 ZsmjpPU4vrJz9EOq1ltx6/PVc2h1luq93dPmL5xSF9lDYLIiI3oSGmwj9uw==
X-Gm-Gg: AYBFou3fw9xvlegabA/ET78mKlPG6M/Mog7BFzk39TSj2BCC2V8U2d1lLRa6V7GO62X
 sV8gNnt7XYJEsuKDYPKhJu8Ox4qlaGX119qqkCVD9xyydZ9jxPa9Q86yRP9Kadpe8z1u3jystJH
 +Op4DUHPFNmDyHcyN4ZDK/H38utq2s/QQfT3q22xZ+nFIqbxSxI9V8xmQTO8A48hckNcZW0dmMl
 zKcRVA4X+fCiGnaZ/dy+ZhQaoFe02DPwGt5YMYqSyoap93zu4UDf1AJsnpilpu8bKIO1CEHAD6p
 UQaUt3D/iBEqbqiH+tpGU9hJ/vm11K69S/zKhXuL+/f+EfCKD2VOuhxiqoEYx43BIGm6jPZMXoi
 cloQz/vI0vZ1Jgu3kuNVR2iNvhsAhIlKn1vCO
X-Received: by 2002:a05:620a:4886:b0:93e:c12c:9b6b with SMTP id
 af79cd13be357-93f57f82894mr829903985a.70.1792675310203; 
 Thu, 22 Oct 2026 06:21:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4886:b0:93e:c12c:9b6b with SMTP id
 af79cd13be357-93f57f82894mr829899185a.70.1792675309720; 
 Thu, 22 Oct 2026 06:21:49 -0700 (PDT)
Received: from [192.168.68.64] ([187.106.240.201])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f56c6f16dsm519415585a.4.2026.10.22.06.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 06:21:49 -0700 (PDT)
Message-ID: <1ce16776-3338-4b3e-8206-48c17ad1a776@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 10:21:45 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/cpu.c: duct tape fix for QMP + RV profiles
 introspection
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, philmd@oss.qualcomm.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20261021173138.2388231-1-daniel.barboza@oss.qualcomm.com>
 <87ecdil1g3.fsf@pond.sub.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87ecdil1g3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1MyBTYWx0ZWRfX0Hr9wxO2RNCH
 XrzSmwk82fMb98lMVEwnj+GDc/pJZOARZh4h7z0Wtkh2/iey6GkCxqYk9jh6A8+h8Ud4wtz8JnJ
 k0g16/BtEO0kke0gJnMGDv9vrGGXlYc=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ada0def cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=7SJRNfuEitxYTu7vBacxyQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=ZiMIAIO6AAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=WOXBTGftTibl2L6nbU4A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=KohFQSMcaiS2QNUyYz07:22
X-Proofpoint-GUID: 7ydsmy1ek-zfb2tHJoHLrcovWAka--nS
X-Proofpoint-ORIG-GUID: 7ydsmy1ek-zfb2tHJoHLrcovWAka--nS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1MyBTYWx0ZWRfX7L0Wtwc3BIFZ
 2Sh0/fauMTJFTbFB6JaCsLX15rNaAiBAOk5FpHB45FP4J48y8GH1/K8XRVEug0ys39Gop0pZ14Z
 J5JVn+HIKeFTAaIwMFNLrhDiMTsmhgMsDRDJC0OPQaXfJjkz4UEkwOj5hUhkHuEEYsyd4vUwX12
 ke9p1EFBNOhWfuy5ZFpqWWtvdUuO8BItVCcKl/cxZ6JuC3H7sALKy8LLzJg7hnZsu1xijax5iTX
 2hleG9PCbYkceSsJJCRsksVrvNqt75daYgyiS0SHYSNpDmCSHthk55V7GZ4GsJKnIv9AsbGvJbh
 mDstkq2uhX+6sxoGu/a4E1p0l9b1xOWmAnFQXZiKOGatIInMzFU5Yghtto4GNFLiSDONEbeNT/Y
 8sezUm37CobZxJaYn8azefsmRaHIGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220053
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/22/2026 3:00 AM, Markus Armbruster wrote:
> Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> writes:
> 
>> Maruks reported in [1] a problem with QMP introspection with

Just now noticed the typo :D


Alistair, can you fix it in-tree or should I re-send?  Thanks,

Daniel

>> qemu-system-riscv64 that happens after querying a profile CPU.  QEMU
>> crashes hitting an abort during satp_mode logic that, somehow, is being
>> triggered via profile code.
>>
>> For every profile CPU that goes through init we're setting an 'enabled'
>> flag in the static RISCVProfile object.  This sounded like an okay idea
>> back when profiles were introduced, but now we've realized that QMP will
>> querying CPUs without exiting the QEMU process while also going multiple
>> times through cpu_init() and friends.  The result is that we're in a
>> situation where we have runtime information being stored in static arrays
>> that persists between CPU definitions being introspected.
>>
>> A proper fix is to get rid of profile->enabled and turn profiles into
>> cpu->cfg flags like we do with every other extension.  Unfortunately
>> we've been using profile->enabled for lots of things and a redesign
>> would be in order, one which I'm not comfortable doing right now - we're
>> too close to the QEMU 11.2 code freeze for such a change.
>>
>> For now let's silver tape a fix in cpu_init() to reset profile->enabled
>> for all available profiles.  We'll do a proper redesign in the next
>> release cycle.
>>
>> [1] https://lore.kernel.org/qemu-devel/87ld7rmdi6.fsf@pond.sub.org/
>>
>> Reported-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
> That was quick, thank you!
> 
> Tested-by: Markus Armbruster <armbru@redhat.com>
> 


