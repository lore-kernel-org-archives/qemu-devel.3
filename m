Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DA1CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHknA-0001i6-Qa; Fri, 16 Oct 2026 12:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkn8-0001hj-Fc
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:28:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkn5-0002sE-2B
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:28:20 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5ixU996806
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pP2OGp18ShphQY27eXYs68MAkirNEu7P6W+CbBJhe3c=; b=dXtdBciOjRbowN82
 iU7SfWWJIHB5gz9L7TmpIk2ofrrbUNxQHThuz0Bwvuz3OTKXKt6uleTVwFCtGTQn
 xH0VWYaIx2DYwUsFcpBsZOH5iEti4YRVhJBthw6yKpgJB4X+4JiKYV75KBsCWhrG
 pSyDnpTlJ0FXRHA6v/mUfF+yE4kNL/CLFHbf9PwG5LaB5k5u+tgIWuZXo628yPYE
 8EcNtrN9L9SMOPGKWGcHRUjHPK7ji54ad3m6l5Bq2Y4WXAR2sqEr77OQjAs6WH/W
 qbxeHvBRF4w8SdAmSCE8AwCpacShYv7tX9lVGKIXEkcQhByDN5+HQdFQusozl9X0
 rvZ6pQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbcjtaqk8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:28:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35fb6be0f9fso126990eec.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792168097; x=1792772897; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pP2OGp18ShphQY27eXYs68MAkirNEu7P6W+CbBJhe3c=;
 b=NO/BM23p7SBpjG7K3v9wGXX4QDxt/tHp8QtOu11j2QFZYDKPQkZO2NX0G0O/0GAYU+
 gMfGIBiCxDECmP1NjqqKKmCHUYXT73TYjmtb1lbzFSB2gwGITiU4VhvZSTyOkdMoqrFe
 ADOT9TFAFTyBAg5OtOeo/h5BIPUn8F7cqr1gLD95HyudfgEydnSckt/dyaHqMPiSt0pd
 Y9epz7tuQ8QE042Rs/X4PIUAo18VULo1S1fZtLIhq3/cPbvlHmH48pNHpCsfaA1ysmA3
 5KgYhHP+s/AifscNE7TfJjyh+ud/Vx6jVyFutq0BxF12umDsqw0GYRtpMIDtEk/7Dl3X
 6aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792168097; x=1792772897;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pP2OGp18ShphQY27eXYs68MAkirNEu7P6W+CbBJhe3c=;
 b=ul6gpalIX9EXm75y+tB6b01iEaZHrx8Q9Fi5stA5DnWI+i4gzxJHCZcELTL/+KiboD
 nrCv5sCwmklft2Ys2CZ84J51ZMXTAEqGaebgBL+Wq9NKF2UX04iDvI21bh/tmin0i2e0
 hLWhCWy2kqzG+5oOLbRBJny1MwexsxxEWv4IQiwb8brn1Kq8V6W03lGSbq/uvRJQkeDu
 PgMD37r33ZzdKnfO14IlwHqzSBnngEaXgr5kln/aWMqjNO7KjeRQR/5EGbkougUxxbd7
 kdPlfrpOI7V+xRu0D+W5GslXCCMebCwL3WgykXrCpKzkUIBrx5lydP2NJSI+7IzRvdh/
 sVBw==
X-Gm-Message-State: AFq9FYIZ1NasuzsHFUv7WF56RztpUpWv8SYR//xcikXKMJVSiWEvV1KF
 5uSO9dcfCPToMzEQbYTvDhhUA+NQk26XF4Htj5cUPEczBRnM4etIsWGYuD/m7DUGVoprrqLMNzw
 qdAli8u18vFGNr1mvuV0Vb2bqQvNG7PIaR+X2QeKN2t27/AmHvNGnXZ4tOA==
X-Gm-Gg: AYBFou2vlR/QHKa2HC6tAMav00GA8fLbPVdESibuMp/nUiPj4qlxgTH1m8j0stwhKiW
 mKCFbTwihdBPf9C2YaqMm58UEBNKlnQqOtfwg0VxwE3rLDLuXypwFOo1wX0V8O8gg5MK/guM5m8
 Ey1JzBbL5oowMo/FBxIby1837MoFqXH1A76asRPW4pC0witLlkqXqZHkYXfcwIxhy/NsPfk65as
 0OxPkmlpx0FWEeRiLSLTk4mX9dJcM8ZWb9wR+oZVbpD49UN/ROo2Iky2COzShynQmoREQZjXO+i
 1VUYAHiKTu2Zl6Xk5FLdEX7lRyezwdBh2u8vBoIc+fDX405dfb921EVF2ny78lCuZWM+5YNzTL0
 lYh513PTixfy6KEYThljJbZWcyALMH0R5VRtKPB1hf4lL78IjgHEDyFWvDeJyVymlMMfIvA==
X-Received: by 2002:a05:693c:8092:b0:35c:ea0d:a9a6 with SMTP id
 5a478bee46e88-361a2942afcmr294963eec.32.1792168096589; 
 Fri, 16 Oct 2026 09:28:16 -0700 (PDT)
X-Received: by 2002:a05:693c:8092:b0:35c:ea0d:a9a6 with SMTP id
 5a478bee46e88-361a2942afcmr294913eec.32.1792168095721; 
 Fri, 16 Oct 2026 09:28:15 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608258aa66sm9695591eec.20.2026.10.16.09.28.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 09:28:15 -0700 (PDT)
Message-ID: <dce3fbdf-d826-4af2-a897-7e4d652ef54a@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 09:28:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/19] hw/core/sysemu-cpu-ops: add get_note_size
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, anjo@rev.ng
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015213236.157767-12-pierrick.bouvier@oss.qualcomm.com>
 <179214395193.1157317.14271435744444195371.b4-review@b4>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <179214395193.1157317.14271435744444195371.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX19V6YPTYYu5L
 kLlelMJBCR1KkjZ4ul/RDHb36/bNkd4YwWG3rU4aZ2xD1T/qq9jxzY1hLkTAKACbBAJrOFWUBj/
 PujZG7M9jIGR5eGRfi7Zsvn0CKWWn5ixxUQLrJ03sYO8WVDKgPRvrcoboiGrN89QDNwKKH+GaoN
 5bbHR6v5gvRXuLaeUq+6CBomO7EHmPKDBxk2fwl9q/j/deKZqJDPGqHVy/KJ+5H4AJbDa5xS93i
 pEYe0NDNyw0+CjFlvC5a0UCu4BVLebf3vCC1RpOnetQmdJNvrIYJxy6uoDSpvGRiLfslqkO5ks2
 RMcqXJIBqMIhAONdHBC3QpuBOW1aAn700ddGg1ehlkMOPB79wjpvtoHQ/uj/cfSLFcQrEiTuDJR
 TeJoSiG4MTYhOZ53AwW+o7lAyGwhVhGvDolItOowBVBzrSkj2yJsJIc0XvC4ono871WvAOsuwTY
 99n6yNH21p8gCm/CmKg==
X-Proofpoint-ORIG-GUID: hW_XMCQJGTpiRR54pKJTmI4XkkAYzxcu
X-Proofpoint-GUID: hW_XMCQJGTpiRR54pKJTmI4XkkAYzxcu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX14iCWgtUbp0F
 bdiYSFkXjyC4qZNog6qUka5dRXCk8TAQIoK6pR3JxmQ0sJwAkgFLkV47SgQtqH3q2AaZjuzae5H
 IfB5CuUDvpPMWeC14aOIQKv9JEV7kS4=
X-Authority-Analysis: v=2.4 cv=VpS2kO2n c=1 sm=1 tr=0 ts=6ad250a1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=gtoTnJNf0odN64OBX4AA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160065
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/16/2026 2:45 AM, marcandre.lureau@redhat.com wrote:
>> This allows a specific cpu to report the size of the ELF notes it needs
>> to dump its state, alongside get_dump_info.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Message-ID: <20261015213236.157767-12-pierrick.bouvier@oss.qualcomm.com>
>>
>> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
>> index 0b6bb42dc2cb..31f1674d3247 100644
>> --- a/include/hw/core/sysemu-cpu-ops.h
>> +++ b/include/hw/core/sysemu-cpu-ops.h
>> @@ -101,6 +101,13 @@ typedef struct SysemuCPUOps {
>>       */
>>      int (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
>>                           const struct GuestPhysBlockList *guest_phys_blocks);
>> +    /**
>> +     * @get_note_size: returns the size of the ELF notes needed to dump
>> +     * @nr_cpus cpus, for the ELF @class and @machine reported by
>> +     * @get_dump_info, or -1 if this is not supported.
> 
> dump_init() asserts the result is never negative and implementation don't. Let's
> have "... for the ELF @class and @machine reported by @get_dump_info. Must be
> set if @get_dump_info is set."
> 

Updated for v3, thanks.

