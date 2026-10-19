Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DE9606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DA87J02n;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RKTL56wq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIxFm-0003TD-GY; Mon, 19 Oct 2026 19:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIxFk-0003Sq-3J
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 19:58:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIxFi-0001qE-4W
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 19:58:51 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JNlHZI043774
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 23:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2a0CyicwmpFGw2+AkD6KN+jOFuPzQ/i6aLf3xuRzzyY=; b=DA87J02nJq+WpgCW
 C6MH9jkJfGDv60sr6XFJ6O4D5JIC9ab0bDqZj7YHAClMFul10Oj5uyMivavPc7Ak
 cJI/ZDgU3bYmdsipkDkn4SyKSGV0JDQO/UbUj2t9x5gMCJpUZuFo1D6yo1v/OUGu
 5/N51Ec6r/8BMyC0hQq9lqSJxx2OS1ByGUtSs+4CpCHsX8yV2K9sHxhkF8HND9pI
 zdCzFNcJ+6DFIP1WhX3Z7k6Ib8pyoZU+I0bnYV9et6cUQ9nSDIvZG/7J6fh94/U9
 hrpPqw8MbGAp7SGXUGM4D5HcULvCcicVhqmppoh7/aG+k5GmT1V3iRDnHijD2dp4
 OD7sTw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nr1tw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 23:58:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5364f562140so4487271cf.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 16:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792454326; x=1793059126; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2a0CyicwmpFGw2+AkD6KN+jOFuPzQ/i6aLf3xuRzzyY=;
 b=RKTL56wqwqryYP33Xg00oEfKbQic5heg6XAULl1dEJ+P6P0dcvUESFLMiljlf++9Cv
 fy3EmY338gPVFINlNOnqCAyRp2CeP3YneamQWYOJIzRn3lKyHSHSg5LpC49sCR1LP1m7
 zxNJwkRRS7H/SaWa0CC7eMnsSyiZF4NiQag2xvOt/w5Wp32PoKoRDm3CsmKxgZJLi3q4
 UgZ4J2O1EesfSGa7Z1709oYVl+P/umuBDV3WGAvmSA8hCw8m2j1/s3/9D5Nl+h0nyGDF
 3QrdXI+RFPDCqKxaPqOWDkzJ21IbvCYRGVQgOSeFbYJSFLnupPUolp8i39fwr0X6+bqL
 P79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792454326; x=1793059126;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2a0CyicwmpFGw2+AkD6KN+jOFuPzQ/i6aLf3xuRzzyY=;
 b=Lt7K/C3CsAwSPZyMAbqMMHIcaMeV66gEVDIuK2qBQ94ri/h8n2zvgivpMH51vBMVS6
 z5aI/LT2ATarp9X894iNtB8jSSnA0GBg+1JBqcu2o91uVd82b5g2nKCWPDsDMqm+lTDf
 MsqlsS5qM6suh3vBcqqEGsd/QiGaESU4U90M0iCGLBtF60LbeXDFcTgS7I2Oa17EipjL
 uMZsj0+Z+Pgm0OIQMX83WKh0UHElcu0lR5FGZS4nnjrOO5lAP/QKnfKRPDaqknZPgAMg
 gGU1ZUcLmiUQgIK2aNjDBBY7TTAbiF9lUUT0CsGKAmWZJBfjUlfWiVKuq67sxv2pA/QB
 jQIA==
X-Gm-Message-State: AFq9FYJ7/zOe6y1TFyqeMTPbTWQN/BMkMUs8MruDyCkrLpxTTACXyV55
 O890z347VXZgCsEwSj4nm7PxIlDssgFnz6ueswOD/jB2Nyg3xiarvKBBpEX4A8GxOeGG/TYuPNY
 wXkohiyBBj2ihOfc5lGpNz+5j6jqwFV4nN69AjrRdyrSwTHnOg2MVQksvyQ==
X-Gm-Gg: AYBFou03pvQSVaJkbIz7y2dbHIIU8vSZTQvgUnxNY0xzPIkBYOrg98EIRuBZG6pGljl
 WbqE3V+ouFoh+dnCxxJiMCQ4HC0ghEbUFIGwxrDtc1NLRlVAyJKUC4ksYJvdQ/1cWEHxKvNRr+P
 KbIrQiHuk1B2YWMcEmnEb3ZCS591c2Moo3ymnlU5Oe8LMHWg4gNdMpW7LjoSS6hDOudeuFx3i/C
 UjqvDMrA0O8U2p6F+MxuzzXCFp5cLTrEyoqSQ6gmC7p7lyv5wbcmx2nwbwz/16iUXItzua3Fcgz
 yp8aZu9k1CZTQBW8IaBfICXgC1d8qiAzmotlopClZec50q6WoqDbbnzw8BEW3qaiOIJeRDBGIaR
 9Lm7rQRANAAAQSsCkqUoFQyVLkL2YPIqJk+XZ5lNzukej7kjUhVy++0FellOpJ+QUzxx3fh+Nwp
 6AeVY=
X-Received: by 2002:a05:622a:1483:b0:536:6701:2112 with SMTP id
 d75a77b69052e-53687061f18mr10913591cf.30.1792454326317; 
 Mon, 19 Oct 2026 16:58:46 -0700 (PDT)
X-Received: by 2002:a05:622a:1483:b0:536:6701:2112 with SMTP id
 d75a77b69052e-53687061f18mr10913471cf.30.1792454325850; 
 Mon, 19 Oct 2026 16:58:45 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c040e6667sm9790516d6.39.2026.10.19.16.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 16:58:45 -0700 (PDT)
Message-ID: <498789c9-a68a-4a28-b91f-ba01599a59a5@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 18:58:43 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] Hexagon: add v85 CPU model
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-2-brian.cain@oss.qualcomm.com>
 <ataaJllUMf-2zbOx@hive.localdomain>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <ataaJllUMf-2zbOx@hive.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Oi30rzX7WG2exJdpFtGPHgGdQvoa4rpx
X-Authority-Analysis: v=2.4 cv=DZOCOftW c=1 sm=1 tr=0 ts=6ad6aeb7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qYLBKkZpVvGOrTE0xUIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Oi30rzX7WG2exJdpFtGPHgGdQvoa4rpx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA5NSBTYWx0ZWRfXyJHGxP5tsJwM
 6DHXf21EEh9yP9u4DiCuiU2fS1K3rL6RHHaWxJVxEqLZh3ea83jT5i4x8UG9sH76QMaeDsxnX3v
 bR117zLMhacyhhXUgXHR+ecy7dWcya0+tLsvOlOxjZ7rK1r2/Ye2H13oCdRFnPjJewzNYvnoZ18
 mPol1mxAKlVfEVHoe2HOxhSZ72fZn37Uwp7jVIYRHMGELVm7QP6NMi6lAa4aPMfU+Q8CFrcTiZN
 DITsd+i9fBnzUIfief3jf+0y9+C6mB/c0EL1y9nq7om71301hJdufgp6lw1EuNtx2yJ83LSv54k
 CpfZOO3W7d6VyYMwnQWqlgiMnGyxyk6WGmWiLEplNSWbX3JLV0hE5qGlyyzx+qiZpVJain2SwkO
 IAkwx22yoFDBi9NbM8D+c5w9e8iCVKnahMnlU6ST+Jw6jPUMZUUjVhEPNpDlRw4pZjCTuV/ht9o
 R3tN8vQ2fmrua6zR44g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA5NSBTYWx0ZWRfXzKYXdvDD5LCR
 JaGPG6AuKC/vlgf173+oQdHjKfO3CbJeyQGaOmtpY+U0myJ1OG8WYcEqh2Lfgf0ijQY4l7Ee8kw
 b/i1J+37ywjUsGKNxlHwJ8J4jcdnpkc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610190095
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/19/2026 5:32 PM, Anton Johansson wrote:
> On 19/10/26, Brian Cain wrote:
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   docs/system/hexagon/emulation.rst | 2 +-
>>   target/hexagon/cpu-qom.h          | 4 ++++
>>   linux-user/hexagon/elfload.c      | 4 ++++
>>   target/hexagon/cpu.c              | 2 ++
>>   4 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/system/hexagon/emulation.rst b/docs/system/hexagon/emulation.rst
>> index 12385311aa4..fb57c77ae90 100644
>> --- a/docs/system/hexagon/emulation.rst
>> +++ b/docs/system/hexagon/emulation.rst
>> @@ -6,7 +6,7 @@ Hexagon CPU architecture support
>>   ================================
>>   
>>   QEMU's TCG emulation includes support for v65, v66, v67, v68, v69, v71, v73,
>> -v75, v77, v79, v81.
>> +v75, v77, v79, v81, v83, v85.
>>   It also has support for the following architecture extensions:
>>   
>>   - HVX (Hexagon Vector eXtensions)
>> diff --git a/target/hexagon/cpu-qom.h b/target/hexagon/cpu-qom.h
>> index 2bfa4d5d0fc..d4c8413ded3 100644
>> --- a/target/hexagon/cpu-qom.h
>> +++ b/target/hexagon/cpu-qom.h
>> @@ -28,6 +28,8 @@ typedef enum {
>>       HEX_VER_V75 = 0x75,
>>       HEX_VER_V79 = 0x79,
>>       HEX_VER_V81 = 0x81,
>> +    HEX_VER_V83 = 0x83,
>> +    HEX_VER_V85 = 0x85,
>>       HEX_VER_ANY = 0xff,
>>   } HexagonVersion;
> I think you missed adding HEX_VER_V85 to get_elf_hwcap(), currently it
> would take the default case and return 0.


Thanks!  I borrowed this patch from another series so that these two 
mostly-independent ones could be reviewed separately.  In that one, I 
did include the get_elf_hwcap() update.

See https://lore.kernel.org/qemu-devel/20261019172603.2625677-5-brian.cain@oss.qualcomm.com/


> Otherwise,
>
> Reviewed-by: Anton Johansson <anjo@rev.ng>

