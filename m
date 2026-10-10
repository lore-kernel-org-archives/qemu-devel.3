Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA80CA9ECA
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 23:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFgMJ-0002cI-KH; Sat, 10 Oct 2026 19:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFgM3-0002Vs-FU
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 19:19:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFgM1-000416-8z
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 19:19:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69AMAcsw2794008
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 23:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dVdcNH1TlNO81tWMpX9TsvBmIDZIjedVZN4rflzkdAY=; b=mlO2nOScRBVmYCkZ
 a4G37tiL92dHAf7bYoxcdSAqlFA7X7bBPqEXVN6erUOKIr6OYTKyYvYoQQrUqyMv
 AtArbGctOhhk3R57s/j8K/7XlXskTqEj6fIE1qAUhoD3teFqbpg3ghYYe25nvQoB
 /nZmzMGtJsSldijGnbXoHTocdf9TVbl4s51syueWWdi+qySEmAsKzHhKvWrDdz4J
 TKOtqabovFOYLox0VtRGXiqaGpkFP9gNCwbcarOA0KBfINnWFtc+44Y3LZg/436q
 nIHFi9Z8rH/7oKrA9BNgw+ou3WY42npfPwrue1Uqwp8VN/vW8oLhRIY7NUa16Yif
 Um961Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7casa4jh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 23:19:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a8ae5154e7so610675a91.1
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 16:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791674386; x=1792279186; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dVdcNH1TlNO81tWMpX9TsvBmIDZIjedVZN4rflzkdAY=;
 b=SoAjpyJE4cFfmn4zNh9g0Zqc/a+Kb57C5VMi5lDZjQAyhjL9o9GVmAEnLYOm23p8Zk
 OJAaFNR5WOddgUrarNd6G9eAZAsIOGFgy1Su2Zg60fsUUDu7IyEZKPosdO3G7DsQWKOl
 v0+p7MLJTqoMfnltNnqcXGxSQoHc4E/apwGl8/15KC9Xy782g6z9HbYiKb6Di4c89Ng3
 B6yWnJnucaWifQ919nreoUHRFedBLJcUzW8cKLULXCuk1wXRpQlCBmdFlLdeaVRDE/FY
 jQx8POikwaMDfDnFgrwYJy3+IkpoyMVVy8NeqwDeTcRgIwTczXsoE7OQsvD4ZsLQfTQX
 oviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791674386; x=1792279186;
 h=content-transfer-encoding:content-type:in-reply-to:references:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dVdcNH1TlNO81tWMpX9TsvBmIDZIjedVZN4rflzkdAY=;
 b=tcavldZ8/RncaCoEa6F8gWIqNMdtdtbMAU6f0nPvl/Q6a6VfBvRfEgnvbTLYTIj3Mp
 eOZ8UYrAPTsF4s+JuDplyp388DepAtni+DDiBgZmvfMd4vJSijpod2tMHBI+EQ6iR4pW
 5MlcrbtmOE1jjrLCK0FOSKXwVMGaXV7TxDPinw8XqgfXhL9necToW5nBqqISGrzQ2ZQO
 E18wHwy4dAYw/TcEFPsbC/Rrqfm9V29/ZVL+9EejXPLKw7/nTtZgg4zPhrw8Jy2YQ+tJ
 QlN4xYMalw0sNEcCan6tC2FKqLxAhd4vCwBYOixf3XZMHOnGzhBg8AhxuH+i5bsl4D6b
 pDKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVojlkE4dM1uypcUQ9b7Pih0EI/XXE+TARIz5ahLZKWleQ2Cj70BEGXqdBxOAys01CGI/HQjXaqG7P@nongnu.org
X-Gm-Message-State: AFq9FYKhZPCBJh9fxHRGmylXTIPgbnItvePVVuvClX0J52WwfxR+NIJI
 TfeyKhsFOHbDg0sOaL67jPzHLYv2X6aXd/rniNttuS8qStF2aD/7yVnS58P2Cp0cGSWCUINNYfp
 o98gNKGE+gTOv4dndJib4O4AuK8/mkoteeFx24dd0n40816X67872I7WRDg==
X-Gm-Gg: AYBFou1JUK1sRFNwkWlXePXkLiWHzghm+NAVdxA4KEWgHThbVDokRzP501C0LcqwPwU
 9renqjCctW+fS813A32mSMyWnWf7WsVSu/xKoPMhu8YV4GWA39oMd2a8OwHweaQNND/8PKq/qtS
 hO0bAflXezfQUGa7ezGAK9KxQGVgqSvQdhMtC9P9WBj3iQITfL2xAzGdZIWMnkcDNXILoITx7ng
 zmhL0OdG5cvhV8F9Klcpo54trtaylFGzjeu0T+A7VEekBYt2pUD4eAMRUjuHsFReypeZLQhkWyi
 6Rd2WjS/mj2OTl/186MCB6ytlMq6/LArJl67piHgcbyJ6cVsDKno15nLAshnTAYpvyGTUj5nXA0
 nFAF4dhElQH5zrJxp9mEHcWKRE/LLDX5WvGYWnGXgH5I6WHPJXVe4GXTh
X-Received: by 2002:a17:90b:5186:b0:3a2:b036:ed63 with SMTP id
 98e67ed59e1d1-3ab3ac9bed8mr4414431a91.38.1791674386250; 
 Sat, 10 Oct 2026 16:19:46 -0700 (PDT)
X-Received: by 2002:a17:90b:5186:b0:3a2:b036:ed63 with SMTP id
 98e67ed59e1d1-3ab3ac9bed8mr4414418a91.38.1791674385565; 
 Sat, 10 Oct 2026 16:19:45 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3d9e557b1sm2505938a12.27.2026.10.10.16.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2026 16:19:43 -0700 (PDT)
Message-ID: <5be73bbc-f53d-47e0-8276-2ec1a17af0ff@oss.qualcomm.com>
Date: Sat, 10 Oct 2026 16:19:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] container images for migration-test
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, peterx@redhat.com, 
 mjt@tls.msk.ru
References: <8733vbtmge.fsf@suse.de>
 <bf76b7cc-9de7-4baa-9a56-d638c68a78a9@oss.qualcomm.com>
In-Reply-To: <bf76b7cc-9de7-4baa-9a56-d638c68a78a9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA5MyBTYWx0ZWRfXyayCxSRp41gU
 I2/qjRktx2xQhxKF+twkMBDBgISfGEmZAbBIK0+HmNRAfGSeBGEwX2EPo7rmHbl0MvEK6Frrq79
 sP3WgIHZsIihwHPce0GnRfg/ImL6RAI=
X-Proofpoint-ORIG-GUID: kl_Rs75cpAeiZb3Yi_Yiksf7v2TJ4DKq
X-Proofpoint-GUID: kl_Rs75cpAeiZb3Yi_Yiksf7v2TJ4DKq
X-Authority-Analysis: v=2.4 cv=eMWGH3p1 c=1 sm=1 tr=0 ts=6acac813 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WNWKCTwgbzpqJ4DELLoA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA5MyBTYWx0ZWRfX8eQz4PpD1nv6
 ERDyzRubZQSY1nErZ3TseaimYJizQ37A1Ye9J1FZCIZM6GBw00bI0yHxoDVfAOALbtveIILj2BM
 SHD2FUgLNtRF0okvSyhUAXnYIc2ibG2d8xiuj+RieTmWXfvN9jqf7372Xw+bReETzE2PZmTBrj4
 F7cOS8CI6BHLiJ8utl701aSJqNWqMGTLmYWn++mpu21B3PefE3y8+cCmvBqQzQ2GA+tN8Rg/vdZ
 ms9D1FRwt+AIqsPLhiC9tto0M71QudFQCmk+XrHz1/w9diE3jYC4aAynQBY5xpcX5QKLpIlLYeg
 p8UGlsve+49ExQYU+Ex6dlWwiybfoDlPF4N6HNwhJSYIzZFAI/HCDpd8Dgu7g3mMPdjWOkvEH0H
 2xAwttlZZMUruqxA2tz2DC4nr65uhGBwR1wwyBLUrENCP+GmVG8oGiyLQTyEvkdk4zSv1RcIgbF
 w7DLUtAewnjeo5urh8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610100093
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

On 10/8/26 5:48 PM, Pierrick Bouvier wrote:
> On 9/14/2026 4:58 PM, Fabiano Rosas wrote:
>> Hi, I just wanted to share and ask for feedback on some container images
>> I've been building as part of my testing of migration pull-requests.
>>
>>  From a Dockerfile from ./tests/docker/dockerfiles/ I'm producing the
>> following:
>>
>> $ docker images
>> qemu-build-base:11.0.0                        b6efa198e93a        5.8GB
>> qemu-rootfs-base:11.0.0                       72bcb5418f4d       4.08GB
>> qemu:11.0.0                                   018a3f0f4dcc          2GB
>>
>> This last image is stripped (for size) of everything but a few libs and
>> binaries (qemu, gdb, migration-test, sh) and has an entrypoint of:
>>
>>   CMD ["qemu-system-x86_64"]
>>
>> The point is that I can wrap it in a script called qemu-system-x86_64
>> and run it interchangeably with any other qemu binary during
>> migration-test:
>>
>>   QTEST_QEMU_BINARY_SRC=./build-11.0.0/qemu-system-x86_64 \
>>   QTEST_QEMU_BINARY=./build-master/qemu-system-x86_64 \
>>   ./tests/qtest/migration-test
>>
>> (note that migration-test spawns the qemu binaries itself)
>>
>> I run tests against the previous 3 QEMU releases. At every release I
>> build the container for the new release and at every PR I build the
>> container for that git hash using the latest tag as a base.
>>
>> The reasons that lead me to this solution are:
>>
>> 1) Migration compat testing is special, the two migration peers can run
>> in different OS versions, so their QEMU builds can be quite different. I
>> cannot test using *just* my dev machine, neither using *just* a
>> container. I need two hosts. Or two containers running different OSes
>> that can both be reachable by the migration-test binary running in
>> either of the OSes.
>>
>> 2) Neither the QEMU build nor the distro repos are reliable enough to
>> allow me to just "go back in time" and rebuild at any moment, I need to
>> keep the artifacts cached to avoid rebuilding. Otherwise it comes time
>> to send a PR and I discover that some python piece has changed or the
>> distro messed up the older repository.
>>
>> Any thoughts on this? Could it be useful to anyone? Maybe the stable
>> branch has some similar issues?
>>
> 
> That's a good approach.
> 
> If you want to go further, you could directly host it on dockerhub, for
> debian or fedora hosts, so other don't need to rebuild anything.
> And everytime there is a new release, we would just add the new image.
> 
> $ ./scripts/qemu-time-machine.sh qemu-system-aarch64 11.1.2 "$@"
> podman run -it --rm \
> -w $(pwd) -v $(pwd):$(pwd) \
> docker.io/qemu-releases/qemu-system-aarch64:11.1.2 \
> /usr/bin/qemu-system-aarch64 "$@"
> 
> You can drastically optimize size by using multi-stage builds.
> All images can be based on a common deps image, which contain all
> libraries qemu depend on (~140MB from what I can see on my debian
> system), and then all qemu-* images would be FROM:deps, and they only
> add a single binary inside.
> 
> Final result would be 140MB for base deps + binary size per image on
> top, (from 3MB to 40MB) per binary. And we could have the whole
> collection of qemu binaries available for everyone with a single script.
>

I gave a try to this, see:
https://lore.kernel.org/qemu-devel/20261010231648.3105-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

