Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D18C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whDje-0005mH-KD; Tue, 07 Jul 2026 17:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDjd-0005m5-9L
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:53:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDjb-0004iu-ID
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:53:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667J5aht504954
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 21:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=aBcg9fLdUn6Jq3VP5hLWCEsd
 gbFjNeO0VtTi0kE0BEc=; b=O7r2yCiYjIIG1KSIG6DfASaaopyLsnKkrYnTqQvQ
 qTPa/QbHIijTyTU8P0S6zVhcexmIFzPkdHZdYpKdnXZ3LtWiZy5JKotAno9MnZzK
 tiHrLDaBW2mCq1FoUSXzPSjStEV4AVTSmcLfDi7eLi8xl+bDnNT1TJkBGgT+8tHC
 HK4ICxuoZmXd769OTCMoFL6AYrWsWirOHFe1JELMC/kDZbLwa7UvQttOzvKexp0t
 GqBIHqjoyw4upgVyenCo2N07uUeueYeSo7JffqzoIfLV9cnZaGGQ3AbZt68LJiBN
 ifBgdmeBZv1e8lGGxrEMMlYbkTR8WV0l3tW1VLQhOpW99g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdjbv4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 21:53:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c892143db7fso4107966a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 14:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783461220; x=1784066020; darn=nongnu.org;
 h=in-reply-to:content-language:references:to:from:subject:user-agent
 :mime-version:date:message-id:content-type:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aBcg9fLdUn6Jq3VP5hLWCEsdgbFjNeO0VtTi0kE0BEc=;
 b=K9Y2oC4d3tlIvrhIc4X1UhFpZs0UnRGFoq/+L0uIvzEIsBPU2Mu8AVI/Usc9Ub88i8
 AOSsddDR8+qYBOL18hgtCPz4688iAILhT0bWV7DskTbON1k5isOxl4a5sk1EsO/pvTbm
 etYBpb9nNpeV9PmUZJyr5r+aobIG7T9TOgypxVjt8nDPOQ9mrBt35Dp+3y2ou2UafTPO
 aBnZXAtlXBH7moNvbF2sF3xpGjZXZ9zzQxvDL+jDFKCVf2int0QdwRSiW+FmtoahR/y6
 iMHkWE0bcp4DmrPA+hx9hREC5bCQTqRtrzMmCxpVf8n/n/KoIIN6Ec35LXSg5CdyFY4e
 bVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783461220; x=1784066020;
 h=in-reply-to:content-language:references:to:from:subject:user-agent
 :mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aBcg9fLdUn6Jq3VP5hLWCEsdgbFjNeO0VtTi0kE0BEc=;
 b=Gf3630W8kigqH+sq7T0xW/eWAFu4tU1KO90+Ori05ATZwDo2NzTyK3qtQIzOrzMoFD
 /o6PdYBX3Vb73XzF0hixcOpyAxApRjPmof/KTSbsO59qCyA0MPHXlDPG7d4aUz8e1F/q
 vIHH6claLYczFXQQO+va5QvWNRoO0vU7JB9VSHJdqbPuSpd80NORvsF1LNmWRnKyRshE
 AcMTZEDKLAKycwAG18tSFe8ujNJ6YCvy84ce/7t6mvemDw+pa29VWw0OARmtvmFKlpP6
 qA85nJY+PkNowf2gZOOhhLUmKBtVygelZ3KAJuoonhnR5KzckktUMW/Uj5vaIGQk8MlV
 2MEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqIy1DBnJ9LtQy33LiDubyi9EKYsrrzinI3cEVRDXSk3kZSq7jVTBwKeJq4dQETIQk8j8AXIL78DjuN@nongnu.org
X-Gm-Message-State: AOJu0Yxwl5Sz45YyqgboYisPmIjPXXuAiH7shXBUD7pQNZPpT9Zoj9hz
 tBp55P3v/oLo7jlamlve+JJ1fy1vOWdiqZsiBc9oiOUuwb+JUkCS6nIUDo5kj/RxKGu18VSoi8Q
 VFbSyGZjJifJF3KgiLVI1xLVFggY7TMBWUX4Vc4oTH4PHtpGFyitNmbxYHQ==
X-Gm-Gg: AfdE7clmZXKohay4fomHbRIICTCMOP49E9+Or7uB/ROoER1xge0jqPXeyQK/i/wGizV
 wJYuIwAHo89viZkh6W2nBjS0LbQWu4DZ0/mytmSFl2ezkqR0+AVYAy3bIt7GUWcCe9tCQht1zTH
 u+Ty5awkVsNPPE36TenofUNmOxygaMrbJPeI7AgQIedL7OWkrCXxexsf9D8h2araQ2QAOS/PVW7
 tNjndE+maB2Z4KRaVUKZV/awCd2qk/TSEg0S6OYeBPzErBdoStRzSI3Vv/eWNIUaeG+nnl0RZ0T
 EnL6qR7RIdpTvxKP8Z7ohGC1Ds8EWByDhvXqFKTwbR0Y0AYPcWU5PC8PoivzPEonsfGgIGhb5xO
 XE+na5DaKntMm+JTJ5rpj13Rq45lfOnA/HAD9wst9vDpESKknWrZ6HIY8Ol1GmOl65c7DXsgqNl
 wVWqQ=
X-Received: by 2002:a05:6a20:e20e:b0:39b:dea7:5626 with SMTP id
 adf61e73a8af0-3c08ee369d3mr8792706637.35.1783461220342; 
 Tue, 07 Jul 2026 14:53:40 -0700 (PDT)
X-Received: by 2002:a05:6a20:e20e:b0:39b:dea7:5626 with SMTP id
 adf61e73a8af0-3c08ee369d3mr8792689637.35.1783461219817; 
 Tue, 07 Jul 2026 14:53:39 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c9a1sm13847868c88.2.2026.07.07.14.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 14:53:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------48f5nedkOkcM2Od0iPlPG2H0"
Message-ID: <babca79d-622d-4688-bde6-bfa4abbcddd0@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 14:53:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 09/49] tests/tcg/arm: Tests for new FPRCVT instructions
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
 <20260706103752.320511-10-peter.maydell@linaro.org>
 <99c7bbd9-5a77-4145-bba9-9f5ab6f2a74f@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <99c7bbd9-5a77-4145-bba9-9f5ab6f2a74f@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4d7565 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=KKAkSRfTAAAA:8 a=3e07XQf6AqGvvK3VC_UA:9 a=QEXdDO2ut3YA:10
 a=3zGdDJLpS8I3mbvQAZ4A:9 a=B2y7HmGcmWMA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: MhcjRCDs0LQIcOiZQk7T6uY941dKy0va
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIxNSBTYWx0ZWRfX7PVHWmEkIpSV
 Qn4YC0VKOLtNn8nVWuPvdRwvZf33xZtXpT0UFw2tAKubB+y2ZOGOxBRLOmEJvsF8MQFGUm8QELP
 ksSMttEQhr0bVAs6LJPsCsSNG3K7iVT8mBPPtWac2rUSenEx8kjyoj+tWYYLyxS0+kMaTOcMxKA
 KFvFpxWnmptr1K5kmOfamW0hpHmJ/ZxvVYZvIbTbWTm/PWUVyVnGXS7vnsiNrrUB485lSQniS/4
 gITUiMHe9bsPJC10DtiVQJVviAjD+qq8RZepcdHTjKkrVnLrELKyz1ucSZ3xwEmH30gHlWLPjLD
 sW4EPahId1hhsIXkyaVBDE0E0JQq0peE74lP0ZU9okORNPljIf/uBjextxgxQcxpQy0j7AURth6
 UzHsS1TtXrfOZvCiIAIfWbgeKS5EHl/f6xfPfJ1Oyp3KcMJsuWdFkKi7BIa00/9E0loPmNCr59L
 Y3TreXwdOkVmUXIYSkA==
X-Proofpoint-ORIG-GUID: MhcjRCDs0LQIcOiZQk7T6uY941dKy0va
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIxNSBTYWx0ZWRfXzfSALPMdGvZx
 hO6r6kJZESkMNgkTniwuHVXDRO3O8jea1N4GLXTc2RNHIr1iHigMoQGs/AgqPkiHA5505+FLqO7
 El9u3nBvJyoCO8vypzDvaH/b3gxzA7c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070215
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

This is a multi-part message in MIME format.
--------------48f5nedkOkcM2Od0iPlPG2H0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/2026 11:59 AM, Pierrick Bouvier wrote:
> On 7/6/2026 3:37 AM, Peter Maydell wrote:
>> From: Jim MacArthur <jim.macarthur@linaro.org>
>>
>> We autodetect the presence of FPRCVT in the test cross compiler,
>> which is a recent feature in GCC and not supported by many distros
>> yet. If this is in place, we compile the existing fcvt.c test with
>> an extra compiler flag which uses the new SIMD instructions; the
>> output from the test is unchanged.
>>
> 
> Regarding the current work for moving tcg tests to meson, it creates an
> issue since compiler embedded in debian-all-test-cross does not support it.
> 
> Should we update the gcc-aarch64-linux-gnu compiler to support it, so it
> runs out of the box? Else, this test is basically dead in our CI and
> most devs machine, until next debian lands.
>

Unfortunately, even debian sid does not have gcc-16 for aarch64 cross
compiler at the moment. I solved it by using a raw opcode for the
concerned instruction (see patch attached, I'll include in next version
of meson tcg-tests).

Regards,
Pierrick
--------------48f5nedkOkcM2Od0iPlPG2H0
Content-Type: text/plain; charset=UTF-8;
 name="0001-tests-tcg-arm-fcvt.c-use-raw-opcode-for-FPRCVT.patch"
Content-Disposition: attachment;
 filename*0="0001-tests-tcg-arm-fcvt.c-use-raw-opcode-for-FPRCVT.patch"
Content-Transfer-Encoding: base64

RnJvbSA2NDRhNDEzMzc1YWE5MzVmNzY2ZjI5ZGQ2OTdkYzAwNDE2NzM4ZmUyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQG9zcy5xdWFsY29tbS5jb20+CkRhdGU6IFR1ZSwgNyBKdWwgMjAyNiAxMzo0NzowOCAt
MDcwMApTdWJqZWN0OiBbUEFUQ0hdIHRlc3RzL3RjZy9hcm0vZmN2dC5jOiB1c2UgcmF3IG9w
Y29kZSBmb3IgRlBSQ1ZUCgpmY3Z0enMgZDAsczMxIHJlcXVpcmVzIGZwcmN2dCBzdXBwb3J0
IGluIGNvbXBpbGVyLCB3aGljaCBpcyBvbmx5CmF2YWlsYWJsZSBmcm9tIGdjYy0xNi4gU2lu
Y2Ugb3VyIGRlYmlhbi1hbGwtdGVzdC1jcm9zcyBjb250YWluZXIgaGFzCmdjYy1hYXJjaDY0
LTE0LCB0aGlzIHRlc3Qgd2lsbCBuZXZlciBydW4gaW4gQ0kuCgpSZXBsYWNlIHRoZSBjb25j
ZXJuZWQgaW5zdHJ1Y3Rpb24gd2l0aCByYXcgb3Bjb2RlLCBvYnRhaW5lZCBmcm9tOgokIGVj
aG8gImZjdnR6cyBkMCwgczMxIiB8IGxsdm0tbWMtMjIgLXRyaXBsZT1hYXJjaDY0IC1tYXR0
cj1mcHJjdnQgLS1zaG93LWVuY29kaW5nCmZjdnR6cyAgZDAsIHMzMSAvLyBlbmNvZGluZzog
WzB4ZTAsMHgwMywweDM2LDB4OWVdCgpTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVy
IDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvdGNnL2Fy
bS9mY3Z0LmMgfCA2ICsrKystLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvYXJtL2ZjdnQuYyBiL3Rl
c3RzL3RjZy9hcm0vZmN2dC5jCmluZGV4IDdjMGNjNDM2N2U3Li44YzgxYmE4YTFiYyAxMDA2
NDQKLS0tIGEvdGVzdHMvdGNnL2FybS9mY3Z0LmMKKysrIGIvdGVzdHMvdGNnL2FybS9mY3Z0
LmMKQEAgLTE3Myw5ICsxNzMsMTEgQEAgc3RhdGljIHZvaWQgY29udmVydF9zaW5nbGVfdG9f
aW50ZWdlcih2b2lkKQogICAgICAgICBvdXRwdXQgPSBpbnB1dDsKICNlbHNlCiAjaWZkZWYg
RlBSQ1ZUCi0gICAgICAgIGFzbSgiZmN2dHpzIGQwLCAlczFcclxuIgorICAgICAgICBhc20o
ImZtb3YgczMxLCAlczFcblx0IgorICAgICAgICAgICAgLyogImZjdnR6cyBkMCwgczMxXG5c
dCIgKi8KKyAgICAgICAgICAgICIuYnl0ZSAweGUwLDB4MDMsMHgzNiwweDllXG5cdCIKICAg
ICAgICAgICAgICJmbW92ICUwLCBkMCIgOgotICAgICAgICAgICAgIj1yIiAob3V0cHV0KSA6
ICJ3IiAoaW5wdXQpKTsKKyAgICAgICAgICAgICI9ciIgKG91dHB1dCkgOiAidyIgKGlucHV0
KSA6ICJzMzEiLCAiZDAiKTsKICNlbHNlCiAgICAgICAgIGFzbSgiZmN2dHpzICUwLCAlczEi
IDogIj1yIiAob3V0cHV0KSA6ICJ3IiAoaW5wdXQpKTsKICNlbmRpZgotLSAKMi40Ny4zCgo=


--------------48f5nedkOkcM2Od0iPlPG2H0--

