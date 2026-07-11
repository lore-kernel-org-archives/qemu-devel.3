Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFE6C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 18:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wictx-0001dG-A3; Sat, 11 Jul 2026 14:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wictw-0001d7-22
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 14:58:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wictu-0001jW-0h
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 14:58:11 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66BHncmE207803
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 18:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vu3lWM+XHOGc343DVqKEeDZs8Ms0BD1lSJECoRmotpQ=; b=X2K7REJHOJx3Dnaq
 6uGTmDDkN4NJwMwkPVkkhIULsisurpeJtOTqjPMxh1x25I89+H6gwDrO6u1tC6Fs
 xp+ewyR8jzjlC8WIL9+3yxHscX0cDIy81FMjvmIvyazJzGzid+6J2Gsb7MnCv/ZR
 /X9YeZHPaCFL7O2l+f7+MUSm0EChYerc9EossrSl7yIs5vE17IaWA64aT3tB2aX4
 AtH9zU3FIaBXtf2McvsnRSgLCkSGNantv1yBdryVwQXn+MaI61XcwMQJDfmrdpAt
 VKucWVnp22z2J2U2lkxOoIfT5BgwOnDLT3yvsFwjvBHy9PT/HeT1P+K7SAKJURUJ
 l753AQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbekchcvj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 18:58:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a236220so21375791cf.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783796284; x=1784401084; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vu3lWM+XHOGc343DVqKEeDZs8Ms0BD1lSJECoRmotpQ=;
 b=bu1u2JjPJZ3exXiAF8JePKIJIMOgMQQvMF/ILtFBSG65uy87o3eTGK7GfTdbxeuC92
 IP0jrL8r0JWpPHhNEI7lJ4NLk41Ne16fORF/pFwoVcr3Mrzr6khAzh9XvdVrl5tGAVAW
 RPW8EDTxOcy9Qg0Z67jBF0XfZJekH9W+H2+ghNDXTSC6LeqfxYnQSkUYJowJ2v+j2Xht
 mG4UKlxTV8WFMLnR1+1VQeR8e2Mv/p62CLbE9sZk6IsJqUWfQN17MULCv+G7GmhIELOv
 yWNXAJU9s4N3c5DQ2QG25kie4Kp4/pW5HruZ0oqjIbvviu01rJ6SCdhnWwC22CPdSgu+
 F8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783796284; x=1784401084;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vu3lWM+XHOGc343DVqKEeDZs8Ms0BD1lSJECoRmotpQ=;
 b=aJ3dAFbVC25AkZWxDT4xYPPGUIXyZentrk3ZL/fDbEWX96yANU0PcCxFDLIc6m5Xzl
 ua7h1bof50ZjwxHyEjfKnGntAi3lHEIExDhZjSvMMRfuJXd85YAc+cloBGcIwNZ3zqca
 NChu0i8K53/EeC2ovIQYJXKsdmfkvGdx+eqPA+CXAfZdkIldPnVMN5FzZe8uPZtwdJIm
 +D3kZeaEfbtcibLhnfIaFHdIQm2aRPrblb2TwNiXgaPcRwNgZcMHcneWU38BRolCZBtK
 DQIxjiamAuna/0oNp4Cwe8e2lgeCPc1t0IntWyjPv9gT4mMrhexly8pV1DTRpHYkyWXF
 rRVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSGkKBQgHgpY9ZTJ0pR8kp7An9ddDZ5fKxUR4BpgBIeYrcCFwwK3NRsV5rS9Fnwnwtt5aX+/Cy2Uri@nongnu.org
X-Gm-Message-State: AOJu0Yy37+OdgFvNFHvlaVhiHXuxi6WdnqbHb9IkeyjgzHGyEXhHD6ED
 KRwvH1R+HnagdrIJkOlw4eafLcUUyPbg5NYfL9QIS/i33irLaG0HGSvkXVav9d25j7eJmf1rULT
 kjrUmdrBolKhw7XF2tajRGegpNoDaSg0cBYKo4ESN9Ts4G6tnHAPFW5Ezzg==
X-Gm-Gg: AfdE7cnS4l80OKUfiKqgg1ur8miMUHUN2CgIf6i+8Q2Og2ILR7mWky2cKTYmPmF8kBA
 cDkkW1TGQrDPcXg4iOcW/4qbOdtFVNMoR6Ww8ZCgv8Em6HdclLDeQsMbgpJK4dcPaz65iHAntDD
 NA03XrAYz8mtj5T9lZhx/vmsSZFCds4dsFJG9zdyto8yMNR9ccXIWXxV0BRw6eUdTwfY3CntEe8
 hI3raSfgdmxJ1lwdWPONnW3kaz74cfs2aM+hCljiYRy3TUmmJnr0R3bLTJzKVV3fLXN9ajg9fzc
 OBxc+8KjxnXiptEUpMl1W378Zc9dGlbfRhzcgNIoc3BKAUJFYeyX6g/SYxz9KGMpcdUl1gFIL7y
 RsS8ZH32uAvM8fT39KytwGXxDJl4fxxd2KzJ7aACHPR52RN90FVvY8u8RV/QzVDum1Iu3gzE0sZ
 030QzfSHP1Scgqar8=
X-Received: by 2002:ac8:5f13:0:b0:51c:20:aea7 with SMTP id
 d75a77b69052e-51cbf0e018fmr36741231cf.9.1783796283885; 
 Sat, 11 Jul 2026 11:58:03 -0700 (PDT)
X-Received: by 2002:ac8:5f13:0:b0:51c:20:aea7 with SMTP id
 d75a77b69052e-51cbf0e018fmr36741101cf.9.1783796283374; 
 Sat, 11 Jul 2026 11:58:03 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51cbd8efab4sm22523611cf.1.2026.07.11.11.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2026 11:58:02 -0700 (PDT)
Message-ID: <146007a2-6bef-463b-86ab-b317a3d33770@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 13:58:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/docker: tolerate chmod EPERM when unpacking
 hexagon toolchain
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 matheus.bernardino@oss.qualcomm.com
References: <20260619211142.4126199-1-brian.cain@oss.qualcomm.com>
 <dd9efa6a-2824-4cfa-a4b6-4b0201b76aff@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <dd9efa6a-2824-4cfa-a4b6-4b0201b76aff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDE5MiBTYWx0ZWRfX1hzZnctMxh+6
 gshjN5zmTQ3DH2RE7VXy2j1GP0a6LUWODXyQX1AgoN0u5YefEo59Fn4UELw4MnsJ6KKtr0bnV1J
 GgEVA+wVaxxMEp+ejWn56kIJHIZadwKla0fbgKs29b2ZalSfdzmRmNONrX+qFxkzBiBoZ9XKm3r
 v0emHiCxNcTrmIy0RZOehaWYGYd1jOxAMnchJPRJAQdnnhZzAAgLq1EPb3eUsaohI5DHUl2dYR4
 KRa510+hxyHhMpa+ksPWqaqsl8L4OT/hyw5eChQcpucHXJPNtfCwQ0A0L3m5Z5KVQAOSty5SOSE
 C5aa8NC8aKvz7IfGFaSVnvloZlCt4PvoTp94102iaqNQbJCvCPEQAdvW8/30SYdOGCx4Q1iqGmq
 InV1ZQWqn7FCvyn1OfhU5+TghxOgkP3oRcJmgJa3IhFdr1lJf88j5WIyQjYn5kex0upGerQ0rID
 vR4iW/Tbqxiv+nCXuCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDE5MiBTYWx0ZWRfX7DVWy/37lMxk
 FurdIPir38sebeBT2IUCT0MOahKEIYCkKQfCBpV+7HNIaLyop00jQFLV7pknc1JMoNmkL7mO/j+
 +Y4llJcxpd9Bonvc4evHB7EKsexU0w4=
X-Proofpoint-GUID: 3OgZTvzae4kKVtduSsIXI21nVOkay-qe
X-Authority-Analysis: v=2.4 cv=XNsAjwhE c=1 sm=1 tr=0 ts=6a52923f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qC_FGOx9AAAA:8 a=IUHJG8k8DuNNRxiukt0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-ORIG-GUID: 3OgZTvzae4kKVtduSsIXI21nVOkay-qe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110192
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 6/19/2026 4:46 PM, Pierrick Bouvier wrote:
> On 6/19/2026 2:11 PM, Brian Cain wrote:
>> The debian-hexagon-cross image unpacks the codelinaro clang+llvm hexagon
>> toolchain tarball into /opt. The archive contains symlinks (the .so/.a
>> library aliases) and directories whose stored modes GNU tar restores via
>> chmod()/lchmod(). Under docker, where the build runs as real root, those
>> calls succeed. Under rootless podman the build runs in a user namespace
>> on overlay storage, which rejects the chmod()/lchmod() calls with EPERM:
>>
>>    tar: .../libclang_rt.builtins.a: Cannot change mode to rwxrwxrwx: \
>>         Operation not permitted
>>    tar: .../x86_64-linux-gnu: Cannot change mode to rwxr-xr-x: \
>>         Operation not permitted
>>    tar: Exiting with failure status due to previous errors
>>
>> tar then exits non-zero and aborts the build. The mode metadata on these
>> symlinks and directories is irrelevant for our use, and neither
>> --no-same-permissions nor extracting as a non-root user stops GNU tar
>> 1.35 from attempting the lchmod on the symlinks.
>>
>> Download the tarball to a file and ignore tar's exit status during
>> extraction with --no-same-owner and --no-same-permissions. Rather than
>> trying to distinguish that known-benign failure from a genuinely broken
>> download or extraction by pattern-matching tar's stderr text (fragile
>> across tar versions and locales), verify the toolchain actually works by
>> running hexagon-clang --version afterwards, and pass curl --fail so a
>> failed download surfaces immediately instead of writing an error page
>> into the tarball.
>>
> With those options, I don't think there is any reason for tar to fail.
> Also, as Matheus mentions, it can cover some other issues (disk full,
> process killed). So it would be better to remove || true.
> You can leave the hexagon-clang check anyway.


tar's failing because of the lchown for the symlinks.  Agreed: masking 
with `|| true` is not the right solution.  Instead, let's try a 
different approach using .deb packages:


v3: 
https://lore.kernel.org/qemu-devel/20260711185433.2021691-1-brian.cain@oss.qualcomm.com/


This should also have a nice side-effect of decreasing the container 
size significantly.


>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   tests/docker/dockerfiles/debian-hexagon-cross.docker | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
>> index 23e8bb2fb26..fc1e3ef4e37 100644
>> --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
>> @@ -49,7 +49,16 @@ ENV TOOLCHAIN_BASENAME=clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-lin
>>   ENV TOOLCHAIN_URL=https://artifacts.codelinaro.org/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}_/${TOOLCHAIN_BASENAME}.tar.zst
>>   ENV CCACHE_WRAPPERSDIR=/usr/libexec/ccache-wrappers
>>   
>> -RUN curl -#SL "$TOOLCHAIN_URL" | tar --zstd -xC "$TOOLCHAIN_INSTALL"
>> +# Rootless podman's overlay storage rejects the chmod()/lchmod() calls GNU
>> +# tar makes while restoring the toolchain symlinks' and directories' stored
>> +# modes, with EPERM (the mode metadata itself is harmless and unused here).
>> +# Ignore tar's exit status, but verify the toolchain actually extracted and
>> +# runs, so a genuinely broken download or extraction still fails the build.
>> +RUN curl --fail -#SLo /tmp/toolchain.tar.zst "$TOOLCHAIN_URL" && \
>> +    { tar --zstd --no-same-owner --no-same-permissions \
>> +          -xf /tmp/toolchain.tar.zst -C "$TOOLCHAIN_INSTALL" || true; } && \
>> +    rm -f /tmp/toolchain.tar.zst && \
>> +    "$TOOLCHAIN_INSTALL/$TOOLCHAIN_BASENAME/x86_64-linux-gnu/bin/hexagon-clang" --version
>>   ENV PATH=$PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
>>   ENV MAKE=/usr/bin/make
>>   # As a final step configure the user (if env is defined)

