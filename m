Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A97CA6018
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 00:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEyms-0003YS-QQ; Thu, 08 Oct 2026 20:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEymW-0003Ui-5Y
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 20:48:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEymT-0003O8-TW
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 20:48:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990PT7v2958823
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 00:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0Mz8CaM+nViceMj97fO+v2vep9Dbs1Py3JEb2xl+bkk=; b=azoJMiTCUcI0KKV2
 DRTOn9vT/5xzGh13m5jKsd+BR6xKrKAtlj0wTCLuO+VyBfaSsyHCeo9geeqhPVZC
 TpwND467r2kTAbTJYpXD/UVrq62+9YsbJT1m068eBDuAiWAdaSDoH6iOnDBiaq3p
 6oPunGs3X01brvbrCQyFLN2JIkj6nren5CHRZN03JfbuoIhiDol/17HnL81jFfW+
 aahuJFJcjjUnf1ZeS4bPIyWY3EVBX0YDcoOEHOXolLV9xV8vkpod3UVIwUWnDTta
 y1IyzLzR+QtwYkRlO2YWb1DOx44pVH1xYmip1rRE56IFGHFo0h9zotvhIL4zU8KV
 kp09Hg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ev59gc5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 00:48:11 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35158d674e1so2115053eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 17:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791506890; x=1792111690; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Mz8CaM+nViceMj97fO+v2vep9Dbs1Py3JEb2xl+bkk=;
 b=b7I+ZwTKujNqqurSjJHhUZuMldOPCLr+b+G7nbLaEqIP/QXlz/+Q+W9/nOk3q+zTIH
 TXvLqAj8arHSrSQFoqRmTDqqFPxF6GdIhg8XOgfYq9x62NZt0hFxijQkobMssdo62hv1
 lAV8UCGGicApSN7jASlYkQNEs0Kd47DzI/7Fmhx67UyY7oyAAHtQrAw+7XnoEI+5l4gF
 /qhXMkVMjlsu/mqqNYCR6RZbvQLM+KzWntjqAio7Xa+Vs27LEfiX3Dw4KcUreO4B8Als
 sHKogwiS5lgyiq/41yGVMGV+VK/nuoQf1okb1TnCCSHNKMbK381Dbn9cofbaVRCAMvM9
 Jx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791506890; x=1792111690;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0Mz8CaM+nViceMj97fO+v2vep9Dbs1Py3JEb2xl+bkk=;
 b=iwh9/3kbDkFzmTiQ/rFYSQVsi6WQ0+XD+t9Agu5Oo9ezY4XOsW3LFnDxZOcx/z27to
 JSzGFc7LBJMeHDtdn1gSE58cEWCLNYTbUvQT8mdZ5za7U898XXq8gmwHhZ2pdJRJoSxI
 jMsTGNcV9J/MmLLvUONVU4wZwts56FTf8JdzdQ8ajPb1YD5pNLT6gjKCE51NPDaW2Fwv
 jsSuhwFBkDLJpg7OKTfQJcfmtVoC0RByLvN7AGUrv0cJU9j7rxzPo2AAX1VYKiQkmC7K
 eN8kdaSw/SNz5fSkyOCnRNHxRhmbDG8KYYyGd327X7hXxTTbfPJ6E5982fHrZsY4VRlm
 BNgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvXUw1bYmcM/Nm82HL5Ucnzvf0n/VMLt9HqZeCihEuAyxu6B6Wqlclv4LiaNZut46BFYuBFfhrIk/a@nongnu.org
X-Gm-Message-State: AFq9FYKEh2GQRGwIvUuxha1P754dgARP+qep8MSRtceu/rWSESLXOiKC
 jTvwKYSNCexm0brv9nAW4m8d0PYyeYjbzTMbnWVXYBBuIGSP/1Uqv40yWaEq2UN+AAbSO+l4KRJ
 QgVgYxf/0qJMFO57lhqCBgt/2t0Frg1VMfytSekClJWqF+lk2JirQDSGymQ==
X-Gm-Gg: AYBFou0T7s6HhHDCATMgFNZMZPcCrjA+Xcj3kS5mAY6WLQaYJWYG2Tj+dJ6etYXJtZ3
 j7BPBrvbzScaJi41a5zm3NonyJkCVcocR+Jxkr47J6MDGAuhTTDWSxW6hqQbAdhdi3cVyQJCfDq
 TDp9A9rbaAYwUbgw9jReeQmbIPqMmndgOz+Od43gG4rxC15QQFPcUHU1GVzcrG9OD5I4wOhGrOB
 G11L/qMBJCES4zuf/a5XEIMPycsMDfSevvBbIrhcJhHCs+2yTmpwnYHl6A+kRnMv/omPjNN/RU3
 PgC110WAa4ulISU5QCsHe1YdKahKpJByYJcfoOrwFDTFmUryo0rj4lmip7WLzVRoWFx6uo1Dzgw
 ZPw4P8TW/tpS4QGUALPVwndwgSSSG2ov5SpqGirFjLVtQXaw7xJfLg5M68DKxfU8ap8B7iw==
X-Received: by 2002:a05:7301:1890:b0:351:13b4:9c59 with SMTP id
 5a478bee46e88-3537dde3eb0mr803684eec.2.1791506890119; 
 Thu, 08 Oct 2026 17:48:10 -0700 (PDT)
X-Received: by 2002:a05:7301:1890:b0:351:13b4:9c59 with SMTP id
 5a478bee46e88-3537dde3eb0mr803643eec.2.1791506889485; 
 Thu, 08 Oct 2026 17:48:09 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb2954bsm1661308eec.26.2026.10.08.17.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 17:48:08 -0700 (PDT)
Message-ID: <bf76b7cc-9de7-4baa-9a56-d638c68a78a9@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 17:48:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] container images for migration-test
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, peterx@redhat.com, 
 mjt@tls.msk.ru
References: <8733vbtmge.fsf@suse.de>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8733vbtmge.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwMiBTYWx0ZWRfX9cXpqEnZi9CU
 UUcxmg3H8Ta/WcVwlSBxOYPVGUsrxhZirXmLc+D8Cn88TYi0PfZ21NZn33yofx4gm6ysHtNP5Yt
 IAGBJiEXnwVn/c5H62o2H/DX0llq0I0=
X-Authority-Analysis: v=2.4 cv=MMT1C8Zl c=1 sm=1 tr=0 ts=6ac839cb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=fLrqBC-9F1zM2KqFegUA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: AtQXGpjIAQPAUDrgoeq4dcDsYJXfTWm8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwMiBTYWx0ZWRfX2Qf+Q+Tqn88g
 h0PgVRKLjNlQypilGg1ivO+epNATYim0ZPIRSr5asczfH6EU8aFGuHNyUHd16dFB6FDpJnRY3HV
 5+rnJWXC3/7EhI+Cv/1Ye7LJbO8mwcArpZxyc54OlYRMkhaoKpp95MVeLG0hhhwgITyJDntdfNS
 dG6rhQ92f1ub6gESq8sWAiDveuV3xuS7aRZjegTict45DyJ5GNuacJS0SdNvL6neEpXy9DRrnWj
 X3TJBf3cKFIZzeRWKcEC2nysCBygfNqcrj9KFIOy3A9AHG+5P9dkmho7cX0eoXYtEAc+DCKYgfe
 63ehPpClUxL0pcAx4w7lrKjUVn4hvTLhFCg42PxZ0AwRMBfQbJd14iJC29WcMyqhU9jpbYKgc/R
 ChZgfixNcpqm782NXQaMmxtSzBA//HxF2lqeWBsfqBEXOBmr5cjNJSrNdGx40Alr/nm6MZ7LJC0
 Pu0h6aRxxDif3mVJWdg==
X-Proofpoint-ORIG-GUID: AtQXGpjIAQPAUDrgoeq4dcDsYJXfTWm8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090002
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

On 9/14/2026 4:58 PM, Fabiano Rosas wrote:
> Hi, I just wanted to share and ask for feedback on some container images
> I've been building as part of my testing of migration pull-requests.
> 
> From a Dockerfile from ./tests/docker/dockerfiles/ I'm producing the
> following:
> 
> $ docker images
> qemu-build-base:11.0.0                        b6efa198e93a        5.8GB
> qemu-rootfs-base:11.0.0                       72bcb5418f4d       4.08GB
> qemu:11.0.0                                   018a3f0f4dcc          2GB
> 
> This last image is stripped (for size) of everything but a few libs and
> binaries (qemu, gdb, migration-test, sh) and has an entrypoint of:
> 
>  CMD ["qemu-system-x86_64"]
> 
> The point is that I can wrap it in a script called qemu-system-x86_64
> and run it interchangeably with any other qemu binary during
> migration-test:
> 
>  QTEST_QEMU_BINARY_SRC=./build-11.0.0/qemu-system-x86_64 \
>  QTEST_QEMU_BINARY=./build-master/qemu-system-x86_64 \
>  ./tests/qtest/migration-test
> 
> (note that migration-test spawns the qemu binaries itself)
> 
> I run tests against the previous 3 QEMU releases. At every release I
> build the container for the new release and at every PR I build the
> container for that git hash using the latest tag as a base.
> 
> The reasons that lead me to this solution are:
> 
> 1) Migration compat testing is special, the two migration peers can run
> in different OS versions, so their QEMU builds can be quite different. I
> cannot test using *just* my dev machine, neither using *just* a
> container. I need two hosts. Or two containers running different OSes
> that can both be reachable by the migration-test binary running in
> either of the OSes.
> 
> 2) Neither the QEMU build nor the distro repos are reliable enough to
> allow me to just "go back in time" and rebuild at any moment, I need to
> keep the artifacts cached to avoid rebuilding. Otherwise it comes time
> to send a PR and I discover that some python piece has changed or the
> distro messed up the older repository.
> 
> Any thoughts on this? Could it be useful to anyone? Maybe the stable
> branch has some similar issues?
>

That's a good approach.

If you want to go further, you could directly host it on dockerhub, for
debian or fedora hosts, so other don't need to rebuild anything.
And everytime there is a new release, we would just add the new image.

$ ./scripts/qemu-time-machine.sh qemu-system-aarch64 11.1.2 "$@"
podman run -it --rm \
-w $(pwd) -v $(pwd):$(pwd) \
docker.io/qemu-releases/qemu-system-aarch64:11.1.2 \
/usr/bin/qemu-system-aarch64 "$@"

You can drastically optimize size by using multi-stage builds.
All images can be based on a common deps image, which contain all
libraries qemu depend on (~140MB from what I can see on my debian
system), and then all qemu-* images would be FROM:deps, and they only
add a single binary inside.

Final result would be 140MB for base deps + binary size per image on
top, (from 3MB to 40MB) per binary. And we could have the whole
collection of qemu binaries available for everyone with a single script.

Regards,
Pierrick

