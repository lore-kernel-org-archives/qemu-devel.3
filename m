Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4772C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6B2w-0001LY-OB; Mon, 14 Sep 2026 14:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6B2v-0001L4-0v
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:04:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6B2q-0002r8-Vj
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:04:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0aro511045
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jYdOwYKlHSV/QEZOJO2U7joS6s9r9VYETdNUq2De3CE=; b=gudhGmavFHbbmR/K
 fpPg4PLP1LI7fQF6jxPlznLnlmbLkECL1pUN5dH0rZ3MDRzm5iYjISAtbo6CkrXM
 oFVnHsfaMQhdLrmSGXpDdunVDKZa1vQLtPB8wQJbdmx+7L2m2I3Oxf+VEECo/Py+
 hPuSnlH9eHULKYV05OEL1qgNzoGnrUQNKMBkmot+Z/1L9x2lms91ReJkLJXYYkCp
 oVP+4GsOb03GwdcUWBuZzC523hyXGdThrMO6X22YLDdLnX4gQNG2nQA5JIsy/2Th
 lU4D/WtGqYFg+PpHbJ+RvSjC8j1xNS/wIihJzAX2eHp00nwfWQaHTRaOlUjQ1A0x
 epYuEw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpgvthgcv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:04:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8663802b58fso3708439b3a.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789409081; x=1790013881; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jYdOwYKlHSV/QEZOJO2U7joS6s9r9VYETdNUq2De3CE=;
 b=JQajQ5MCjxwFktkFtsZ3E/k/XG67eFh4ZccQbFVEdR6M2pEAPbYbWxJGiJIJl6qmqR
 3UvcyQ2zHnqZqcyv3PqZnp6z1jFmHVzUVQY/xbyWVzWI/+wq5NEdPMHxLGc3S0YkhD5w
 QZ7T6gVuG9sO/O9Lvs545o56FhAxXsjlpoNM/Ty3sOegtjatK1xEVnQPwYyrXFm3bQWE
 bxaQOyj9WqIq37Cbxq0XNLbEUVU/kBvGdE64Y7VWRWnOhpt1uyKrUqJBDLnjZp3z3odV
 XRJMbVoj98mXT0ABJJKT7x5olTxqCqgS7IT2U4hKVTyDSJSsKJYkxacA3bUIb36hruUt
 5YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789409081; x=1790013881;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jYdOwYKlHSV/QEZOJO2U7joS6s9r9VYETdNUq2De3CE=;
 b=ZqoFpC13SfyQ2DV1csaEtytIMXSck1l/qKyNqHEOIxj2dBjmhAxPRGpE2cpus/T36l
 AFHK9hoZ608eHbPFXf7WvwZj0yWHEGW+ixgNuunaJZODc8ddZpXNskczy8QIXcUoD1P6
 hwCNj0iT2vCQf5zYIMpUhH5T2zIoLaWUdkG6LBt7VVuSKMC197IXMkCZFtQh0H9fBnMx
 zSOyKM0QXiHm2ES2K+WmUZ3USsNMvXyR2kG9h7wk3QBNmgPTSbuplXMsLrVeEPZ8vJ1O
 lPZuCNkN62sAPs5p6qztLn3gEC/x1hDpI2rsIqtZsU7GcDm3T6KNGXYrY1JWMuNhOUgZ
 E0DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByuBjvKqoyGFelDcHQZmzgfkRsPRwfZTWsxuyYsk0/kds2ozoFlmHOC5j+Z68OnaTLlffLBP1GFl6TC@nongnu.org
X-Gm-Message-State: AFuF++lCHaN1WzCgg8/Ve+53i0n91M5onS1Rqt79HZiC4MURhx5qsyru
 F0YqQE14sl67ZXbRVfAH05FLJzw1Pcrr/XhoErJyDG4i0O8SvVWEgMoQ6LRpIVVSJRlTA33Xx4x
 L06+hoWuaTaV9CjOgKbdkhybv90A3MscTTGoazZUmh9zPv+Kkib+pBSL15Q==
X-Gm-Gg: AYBFou0uGGbLUiIx2tWDfbtU/GjFHD8DzsdPq+/O3m2t1UggBRAIKVF6uxIamXH2rcM
 5g3UrJJyUv3Kei3U1QSEO4Hd2s5c5xIUOVYTV0yH+VLdB0CcMdqNuTsYfVO4rRylQ2BXKC+GUiP
 /0rxsjg3pkPtxbbv8ny4mW/7V9/uPHoyU793vwCv4n1J5T0URyHL0pPg7R2pAzDV+iKog1StNrM
 vtw9m6CnuCRhOoD36NSkVtCnZvxG+aqu+FUKef4Uq5ZnLL5rnBcZ+V3y++8A/4XPQCwkWlfLHNW
 BGhFoErOwJWZnpyH8qY1vYL1TAr8W2w1lMzjEQDnbT88IuqVz/dMRlBx+giMFt+grwvhrJGDBqO
 ofZYUbZtFBNFlZVGRbKbwZSCGprTmGQphieYvegYs+5H3gFZyBqJ7vnwTr5X4Gh6kizZP
X-Received: by 2002:a05:6a20:6a1c:b0:3d3:adbf:7784 with SMTP id
 adf61e73a8af0-3db40687074mr7477662637.25.1789409081477; 
 Mon, 14 Sep 2026 11:04:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a1c:b0:3d3:adbf:7784 with SMTP id
 adf61e73a8af0-3db40687074mr7477574637.25.1789409080895; 
 Mon, 14 Sep 2026 11:04:40 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f0feaasm26022471eec.21.2026.09.14.11.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 11:04:40 -0700 (PDT)
Message-ID: <1a8155b3-92f2-452c-bd0f-884c3e0bef69@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 11:04:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
 <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
 <871pavd8ry.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <871pavd8ry.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c/0+0h9l c=1 sm=1 tr=0 ts=6aa8373a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Z0KqDakv1EUQvxTMeEwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI1NyBTYWx0ZWRfX+tHwAdjMSGmU
 IzMItSs+nk9+psDuwtOXLtUAji09qrL69zvLBHJFk7jSl1vYenX0JOh2nbnspAgIJYfb68PnAnU
 d6cEi0V8ORs7Yvd226cu/W0wgFoHlzsKsQ0u9W3zCtVXktvITTu5hCIcxKn0PVX2MaDH7o5uiPW
 NiZKWMSNetVIoYs2VrtSxsQWSqwcO1ngVgNYBdEXs8/7v8x5pTxWeDH4MIjc+sDWoQkZzk8CjoL
 ZIJzsp1BR9FYpewTWR/Jl45SNWArwiEZiZUJjT8W2WjH78FBfMHIoU55lDKhV/MBnYAV4fdzuzZ
 7Mvt3M6QpFluxQCqCuifuxAgqz6MRZPqixm1sCxzMjerMbkY+gbghq14e7JczsRAWlguNmXyUtX
 K8cklFOauyBN7+ZS0aHeG1OwY7zY0OlJM1gNEi7BC+kCcoNqPbLtXWzVeBOeLjOBzelpJie29qX
 vaItNE0QJNjfPVVmFRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI1NyBTYWx0ZWRfXzzG0ZY6aTHp/
 60uaZiOmLlvkd1Omy9jX8p9ShqPuOQFYJYrCnaNgnYH0uEc6m1r/2DH1pBkHX4Od3yMeJjLGHWp
 vLRwRHGjzp2Hwz9W9BWxl5kGyfrwdV8=
X-Proofpoint-ORIG-GUID: _Ywl7oA4Jt61Rs5GFDDeBGBUm569Mon1
X-Proofpoint-GUID: _Ywl7oA4Jt61Rs5GFDDeBGBUm569Mon1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140257
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

On 9/14/2026 10:48 AM, Alex Bennée wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On Mon, Sep 14, 2026 at 6:13 PM Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>> There might be some confusion with what the series introduced. To make
>>> it clear, it does not touch, nor use tests/docker/Makefile.include.
>>>
>>> Each tests/tcg/arch declares which container it depends on, and we have
>>> tests/tcg/meson.build that automatically builds it if needed for tests.
>>> Reverting that will not be very easy to be honest, as it's a core part
>>> of the new logic.
>>
>> If it is core, why is it patches 102...105?
>>
>>>  > IMHO it would be nice to replace tests/docker/Makefile.include with
>>>> a meson.build too. Yes, that would make it rely on a configured
>>>> build tree, but IMHO that's an acceptable tradeoff to get more
>>>> stuff into meson natively.
>>>
>>> That's easy, and would allow us to get rid of
>>> tests/docker/Makefile.include completely, by adding matching targets
>>> make container-image-debian-*. Also, we can have a top target
>>> 'container-images'. With this, people can build them with ninja or make.
>>>
>>> As Daniel mentioned, the trade off is to run configure first, and I feel
>>> it's quite acceptable. What do you think Paolo?
>>
>> The problem is that right now firmware builds are broken, because all
>> the supporting code in configure was removed. I'll review anything
>> that fixes it, even moving firmware builds to meson custom_targets
>> even though it seems quite intrusive.
> 
> I've reverted those three patches - so leaving the TCG tests still to
> run using meson but still generating tests/tcg/$TARGET/config-target.mak
> for the benefit of the firmware builds (and also vdso build which uses
> the same stuff).
>

If vdso rely on this, we need to keep .mak files for now. They
definitely would deserve to be buildable using meson though.

With the revert, we can still keep the meson options to keep existing
functionality, especially cross cflags. I think it's safe to not
reintroduce any container mechanic as people building vdso/firmwares can
have cross compilers installed.

So the partial revert is just for 102 mostly, with additional tweaks to
collect cflags from 101.

> However I need to test the firmware builds and its not quite clear how
> to kick that off. I did try:
> 
>   cd pc-bios/s390-ccw
>   make
> 
> but that works even with the current state of the tree.
> 
> Where is the firmware build documented so I can test the patches before
> I post v2 to the list?
>

With those commands I can reproduce the issue Eric reported.
Maybe try with a fresh qemu repository (clone without submodules)?

>>
>> Paolo
> 


