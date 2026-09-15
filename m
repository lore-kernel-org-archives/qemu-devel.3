Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2AEC88E72
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6HNn-0008Od-Dc; Mon, 14 Sep 2026 20:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HNk-0008IN-G0
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:50:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HNi-0004cI-Rk
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:50:44 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN02oi2133987
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CIWRa3jN+XgNQr2LqzkNWhxIrPLHnrCgRK08TqoJu20=; b=ZD8wyet6pUTSavEp
 fyT9h1iYJQi/lQBmdziWSltyEM4B5TaOvYywQS//L8EIsQCCHBZsPjjl/KhmIjla
 YBdbVQf6CMGcat6QCiJhWM8knmuqmAy3Igw/wv+YRAi9ifNwuq5Is0ghmOucfNLb
 AUqAtpJz07+K6U2jy+fznyxFIFbgoCrhakcXuLjxheNwpgnTJSyUOBupFM50A7TQ
 fRYdeGXClXVKsZ2NuczoutfZcv6bOXq5rqDWakseNm/WwPIMlw0vhSheUXpeu+wY
 dTw6KfM2BYowlKIkJLTRrjDEuLTtjtGHEaUPtagjFWojqnmrz2Tb7yxvtAi8wtPl
 npzfmA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpmx9sgc7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:50:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f57e31b6eso3896582a91.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789433439; x=1790038239; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CIWRa3jN+XgNQr2LqzkNWhxIrPLHnrCgRK08TqoJu20=;
 b=eb7NgwA30xxQuJYgdjFdaDDuLKjjnk0Jw4250iBVDWf8TMFFz80B2uSgkvjI0+kknt
 sFyiUOZYuCt7kcdv2zQkwTOPy3jDBcSdOtrb1wTSNP5tsqXBHxvMi959seoeSdfeHOEv
 /xuDf5KuGII6eABLt7sr3Hwbk9hi5NeQ+VUZUixCDteVX/8Y9TJC5lQciDuGilsJdpJH
 fQbVV4wi8AvTcB1wrpTJtyg5Yw1K2N6hl6VloWrDxp/zoug5/MAkAxDuq/I/avT//Eld
 WYGtTUMD6on2eKkgOfAeX+H7QO6MHVT5kraDf7ut865FO+4Kil1XZb4YzNsoz0hPvZcQ
 YH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433439; x=1790038239;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CIWRa3jN+XgNQr2LqzkNWhxIrPLHnrCgRK08TqoJu20=;
 b=VS6cnH5qxJvSmxv0AXBf75PQSnt8jEqZrw1HfA3g9htI00qO1F8rdVNGnWUeLdnIyj
 h3FnXyiLJp31xbjNORu/+c7KPRvFcgVtU3qS9ENbrvaHJ9TK/d2WNGB2rKQ1w4/bOKYK
 3edtqrAfSnqwfJ1tTPaJ6Rl/qUdZIjTZMBnjwstjkwwNf/fXbKw5qUNzLKbpiDrgAqLc
 tFzfqQvB7jEU8pXoy97+mqMaNKBRhH6OE6qLPF17CLzMVlXG0QIKGtDHTJoAVp1NJqPV
 5HzBgR8P4Hk/gHlxRWcJrYNSapFBhLjvMDJ8FjlCiERmiK/c4mWM/TH9lp+c1gCNrnQZ
 4zGQ==
X-Gm-Message-State: AFuF++m/aVjjSG0jDBw0rfSyy6SmZNYKzA3kqAsQ7f56a8c02/vcJfE+
 c0p8cxkL8S+gp3IRdYADNgb1Kw+G5+Uw275o2/8e8wqBtkY9fcPXsPOxC57DbYnqN6teP4Zq/5Y
 TDmB3LZTStttwkzGoe6ezMa7HImQKG2JMc4TgVp0LCCyYhPUL+6wgocuyXYPC09h8sg==
X-Gm-Gg: AYBFou3ANkuHSaOvHXnm3QZLJ/SWFsVK39bIoybyzHDFRh0TSZev+uP7bqXzsUP3Qd1
 xDoAHqDlmg/c036LWylI5hLufAh0Yg6ppbwSWtpSm6xNSInhW4Wdc/2TT8JVl5LR1lfUOCE+Mog
 jma1W7HHEW6xOQnphegyGVhKRZXrWSljAFVYw0m56pgCFrNETkoTh8xaFLJ7yXpgweiimqztIVP
 8/EiQGJ3jzhOgQQnoN90qlIrpyvsR7llxv2sscXicyujNjlNw7Qj8P6idR2f3YsmBOnLHsesdnE
 O0E3K1KWszm52Ezt/1MZjJRNitwWVpyGMvt70sJOo8aZmvSmBPbonMmtJG8km9LRniZcuBRcc9B
 QwSjg6R7WR8vWxDHU75cGv8d+B0msnWEPRdnbdE1obIHYjyXsygInFQDTjX8eCWPIwgls
X-Received: by 2002:a17:90b:582f:b0:398:e96a:8999 with SMTP id
 98e67ed59e1d1-39dec05fc8emr10523238a91.16.1789433439177; 
 Mon, 14 Sep 2026 17:50:39 -0700 (PDT)
X-Received: by 2002:a17:90b:582f:b0:398:e96a:8999 with SMTP id
 98e67ed59e1d1-39dec05fc8emr10523176a91.16.1789433438674; 
 Mon, 14 Sep 2026 17:50:38 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b97994sm51776274c88.12.2026.09.14.17.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 17:50:38 -0700 (PDT)
Message-ID: <87d671c8-bd4e-4ecb-a0f4-eb9dc9151d4b@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 17:50:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] roms: fix compilation for {vof,optionrom,s390-ccw}
 blobs
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@kernel.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G+KJgNk5 c=1 sm=1 tr=0 ts=6aa89660 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=x02yW_-6Frq6157Pd0AA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwOCBTYWx0ZWRfX47LdVrA1oiWw
 048XOoJdPq02/qktvfvdBsSYyA7HOy49qCAEindUB4XjfqKlte+Q9jDhBMdY8aZ20+5VVYnkjCh
 Z2TaDlIpyspjNoSAIU0absLP28g+ccsHgBw2sGEoID+8w6XAO+GKvmZdOGuz+fdiqVzer1ETPRa
 ZwivBnfWQcBhOawluwm7sCOas62OQdaspMtf28qeCKyQ1rEa3eQ3rhFkSrXVso+KjP1k5jEVaLL
 5wpkkH0YS+3gK54DnawyyyOZ8Vk3zxRn2HdTBSOzUMCWWrg7ft/sz4ayJ/eV4itZ1HxdNBUfV3x
 X+bRXcLq5VryHaDaX4iy9UMwJdeVs3HX4ue5oMYAJ0tEBQy6T0zF6xmH+ImQI3Ic9vOpbQZoYZA
 ytffbN457syKjbjCU0Q5xPrer/UuNr1ZJRY1s1kyRhtSAIthN0FpqqY3X3mVhcST2jpwZJCF1aG
 90zMQTqOAJj9fNdCuHg==
X-Proofpoint-GUID: moHoloHyh0brQjOfDe6wWUrK4_KrGD0r
X-Proofpoint-ORIG-GUID: moHoloHyh0brQjOfDe6wWUrK4_KrGD0r
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwOCBTYWx0ZWRfX/RWRgnccDbta
 cc1Cv7khz66avIG2j/hf2qzxZIwRaV7zwhvw6KK4dsVIcD6hNENfCOiDkrsD7A+ZPVK1fbTOYLP
 kGxtdlqnvksFOYhja92xqgK7Co1vdVA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150008
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/14/2026 5:27 PM, Pierrick Bouvier wrote:
> Recent switch to tcg-tests removed a part of configure that was generating
> config .mak files, that were reused in other places of the tree:
> - linux-user vdso
> - pc-bios
> 
> Taking a look closer, our roms sources are supposed to be in roms folder, and
> there is a standalone Makefile to build associated blobs.
> This series moves the remaining sources from pc-bios to roms, and adapt their
> Makefile to work without depending of config.mak.
> vdso build will be fixed in another series.
> 
> Pierrick Bouvier (6):
>   roms: move vof from pc-bios
>   roms/Makefile: add vofrom
>   roms: move optionrom from pc-bios
>   roms/Makefile: add optionrom-bin
>   roms: move s390-ccw from pc-bios
>   roms/Makefile: add s390-ccw-rom
>

Forgot to update MAINTAINERS entries for those files, please see v2:
https://lore.kernel.org/qemu-devel/20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com/T/#

Regards,
Pierrick

