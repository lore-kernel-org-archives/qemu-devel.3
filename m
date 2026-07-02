Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D80EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfM34-00015g-0Y; Thu, 02 Jul 2026 14:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wfM32-00015C-Pj
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:22:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wfM30-0007Q1-Ez
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:22:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662E3S9d549149
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 18:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z21NEuINIhV3SPq36gKizhQ+ZQNP8uNSSloSvH0o6O0=; b=THS6+iqVEipupdHR
 6IS1sjeZZ3p7rHoQzyuPwrqFObHg6e+lqlkicInqVYUXCPuD5S99Vp7nClI35Aaf
 zyePac2KtAKbw2zYQFt3rtOIvaKFjhsz4QwAdLFAzdxC6exbNttelMykoizoFI+o
 5RIRDi0+eBe+STK5DUYBEsyH7ustIt5hbpSN7G2KMSuIddMMSY324cUBJj66DoNO
 lAvlEx1WGM+4ONCvLQOp3s0wewlHnUQXPl+g+TGaN5VsqAjxOqojiomRlS3J76yw
 ZSSvGR+PiWBluhmAHFqGXSGfJVehqdYNxjPxhY9GkCiAZmtfqazJfw4JeVrwQbHJ
 aVBRzw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98k6hh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 18:21:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8620ee0971so2198269a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783016517; x=1783621317; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z21NEuINIhV3SPq36gKizhQ+ZQNP8uNSSloSvH0o6O0=;
 b=bHsZK036wyiaP8NcGCEheycwY1Qh5CovL8zOH68MupB/vTpcxiTWng24in518gPRPQ
 ExASjQ6BfxZsFSWAHtvHDJuBS5K5vzIYPBCjl+HFxr7n3h0MeMscvFOxPg1N26IVX5TF
 LJCkmp/ItKoMFzTK5rojq9EiZIC8MnRuA+oboFGTqSR+LnlPGoma/lSGdvtm3Sm7yvVI
 9cQXvjs1kfQ1AqskPKDxVa5Nx3xrhxDLci6yw7ToKvqSwJStY1G95SuR+Ox2a0+4+A9T
 blcA7v+S/eszO1OtRhB2/LbxpSx8E4yjAjnz5GjIBS7n2Z2FlkzN5HIrMi2Z7GwEGSwd
 U3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783016517; x=1783621317;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z21NEuINIhV3SPq36gKizhQ+ZQNP8uNSSloSvH0o6O0=;
 b=fJEBZLzfnONwwnc3Kld3dVjJ8Dp/j+iagnNPp2VVk/9Ya5lyPHVhL7YgBpe8/mrMuY
 mnIFlsRV3ZDNS2V74kWzkdSMEIMLDenGx/sYCJjlvboDTdfMqhkGV8MzOO+dL/Yx8bsE
 vuOS89+gYHjtgpaWcqDZqDrtN/NM4kSsUwM5M8TRAlYvoiHP/GTR8WaoIbF0fpANES9E
 KhVTYnUOUGX8zUeigbkBRDkQEeqSAUvRhKJdgEM6ET7OyW4LnffGqBt+YaYK3zx8hOx9
 fZ6Ztk/UodHXW671Q2nbwqtsrucJUifNdkOe9OS2pVGVQQGWlhfLl5lepf0AZNSnHnze
 RoNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CB/LbQ6Rr2QO1BcDjk72MH+9+nUieweSC/2GKv9u/DqaT2kaB3CEPNnjxggpj1//0QDFizWkkQaON@nongnu.org
X-Gm-Message-State: AOJu0YyR16AMF2Ei0NdcWLqdLEeUUwY1Z8ApMRJcvtBzNh2Uoj6fQaPt
 3gdU840X8a8ka/p6gD0K5PZjnb5Boxj5k8kszI4zOqzpqS8rYa3+lQSrrI6h9NUCDl4N711w1O8
 n4MOqmp29L+KFT3Ms+DyONLkwFPVV/vkx8hDud2XtCGKdMs2PqdR/1TC7ng==
X-Gm-Gg: AfdE7cmvOp+QQs/AFO9I9t1VwhmtosM1PETMOIZJrpHC4aY+YnQsOYW0eu0VpTww21l
 tpuiUxFaogpqaATyFCGky4WqeSkGKxGbpF/3rglX45aQue4bCuw08kSi+pt2NNb2blp9iOyu+C0
 6vWIj4VUOgUkIoRupN6XvSF0ffMrBDRe650doymSunab0WqmBo7u4Sc2x27DJ1IvYfRst6PPt8C
 eIjUQdj4Vao36V7G6YoyRQwoYx5jRQdeYjmB3nPHmAVUVypmCaXuDlRin2DexRiHTs3bZOQrDMe
 OdooZfK60wNpGmS7HeTDuUdaZgELYO7UxNXl8wY7EKAT1QrUIOOLnAUEpGW7fxolR/bgqY5vsWk
 t7bGixBfeOm1n50mvD1gcS/yHrqvcjskvtoH8U28UQjEF3VPDN8No9M8rW9NrXPAoWPwDlyyaqe
 2NcPs=
X-Received: by 2002:a05:6a21:e8c:b0:3bf:6237:4d3f with SMTP id
 adf61e73a8af0-3bfed1d659dmr8176617637.18.1783016517345; 
 Thu, 02 Jul 2026 11:21:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:e8c:b0:3bf:6237:4d3f with SMTP id
 adf61e73a8af0-3bfed1d659dmr8176576637.18.1783016516778; 
 Thu, 02 Jul 2026 11:21:56 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85b345sm17946303c88.10.2026.07.02.11.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 11:21:56 -0700 (PDT)
Message-ID: <08184eb6-9acd-4afd-9e3b-65dc89fcbb76@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 11:21:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/23] 9p queue 2026-06-29
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
 <53159abf-ae84-465a-ac70-8ad71fa6c045@oss.qualcomm.com>
 <8700308.T7Z3S40VBb@weasel>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8700308.T7Z3S40VBb@weasel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 70a2eRwrPoCtI9wxMgxLWayPwdSnRtq2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE5MiBTYWx0ZWRfX3ARnWQrwBYje
 A2L3TxyaDM4MN24T3S45fXtUPBA+DP3nlGY//psEsdT8Z3TArZNBAGMlEmnmph21M9WwydEGg8H
 +rckq/ZDhA+q0OA07QoQG8+LZ9BrhdcLU/A1hjzqFo8h3HiDHC7PUD2HZO9g8EkUKT+IKPruys9
 ZeKwJCzJHCPHVGEjnnRugUxkRW7BFLwSae7yr8r3143sYsngrPD1yvqZ9kFU02NQtq8v2UisiSP
 D35k9l/vybsZi6vG5w0N5sL7yO/CxuvcoP7ao8WD8CMK0SQLjoqbVgDx1in3U3vEyhKllrEKGvX
 P2Q5/Yskmc7YS5mSsHUqaSC2UHgN0K6kLOLbxiZBR5iTBpAGH2hHD7+OjGtkX3dWBpNwf9w6tHQ
 +icajuT66U53btvIU4ghg+Dlymq7kFjdJ1rfI+A6lCCHkmXxPNxeDHMFIqzi7hvKz6Lt6Ua/elm
 x+SgA2RgPbKdY6WA7Fw==
X-Proofpoint-GUID: 70a2eRwrPoCtI9wxMgxLWayPwdSnRtq2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE5MiBTYWx0ZWRfX0oHrWK/O77Ur
 ZRT6x79cljsLjcQ2jdK7C/00eZ4Y17+7tQS2n+7AhVWs63xe8a6OvyhNqwFGMPM60n3XVnfhQxg
 vQ1o19tv7B+avnh/oeIPtXsoLgOuWis=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a46ac46 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=2TvHYt2z8pAbdQaHCsAA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020192
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Christian,

On 7/1/2026 9:20 AM, Christian Schoenebeck wrote:
> On Tuesday, 30 June 2026 09:28:48 CEST Pierrick Bouvier wrote:
>> Hi Christian,
> 
> Hi Pierrick,
> 
>> This series brought a test regression:
>> $ ./build/pyvenv/bin/meson test -C build \
>> --setup thorough --print-errorlogs \
>> qemu:qtest-aarch64/qos-test
>> ...
>> ERROR:../tests/qtest/libqos/virtio-9p-client.c:280:v9fs_req_recv:
>> assertion failed (hdr.id == id): (7 == 121)
>>
>> It seems to come test added in patch 19
>> "tests/9p: add 3 xattr FID limit test cases (synth fs driver)"
>> This test runs only with slow setup, so I suspect it never worked and
>> was never ran.
> 
> Of course I ran these slow tests.
>

I should have added "in our CI" sorry. I'm sure you developed, tested
and ran those yourself.

> I intentionally registered these tests as "slow" tests as they take a long 
> time to complete and QEMU tests being notorious on exceeding the overall CI 
> timeout limit. So these tests are exempted from running in the official CI 
> pipeline, but not from mine.
>
> I just reran them with latest master head. However I am unable to reproduce 
> your reported test error so far.
> 
> You cropped the output too aggressively. I need to know:
> 
> - Which test exactly failed? (especially whether it's really a synth backend 
>   or a local backend test that failed)
>

That's the complete log from the command given above.
Note: disk is not full, but the error "no space left on device" is very
weird.

qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: -chardev
socket,id=chr-reconnect,path=/tmp/vhost-test-VZ60R3/reconnect.sock,server=on:
info: QEMU waiting for connection on:
disconnected:unix:/tmp/vhost-test-VZ60R3/reconnect.sock,server=on
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: -chardev
socket,id=chr-connect-fail,path=/tmp/vhost-test-GTPQR3/connect-fail.sock,server=on:
info: QEMU waiting for connection on:
disconnected:unix:/tmp/vhost-test-GTPQR3/connect-fail.sock,server=on
qemu-system-aarch64: -netdev
vhost-user,id=hs0,chardev=chr-connect-fail,vhostforce=on: Failed to read
msg header. Read 0 instead of 12. Original request 1.
qemu-system-aarch64: -netdev
vhost-user,id=hs0,chardev=chr-connect-fail,vhostforce=on:
vhost_backend_init failed: Protocol error
qemu-system-aarch64: -netdev
vhost-user,id=hs0,chardev=chr-connect-fail,vhostforce=on: failed to init
vhost_net for queue 0
qemu-system-aarch64: -netdev
vhost-user,id=hs0,chardev=chr-connect-fail,vhostforce=on: info: QEMU
waiting for connection on:
disconnected:unix:/tmp/vhost-test-GTPQR3/connect-fail.sock,server=on
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: -chardev
socket,id=chr-flags-mismatch,path=/tmp/vhost-test-6J0ZR3/flags-mismatch.sock,server=on:
info: QEMU waiting for connection on:
disconnected:unix:/tmp/vhost-test-6J0ZR3/flags-mismatch.sock,server=on
qemu-system-aarch64: Failed to write msg. Wrote -1 instead of 52.
qemu-system-aarch64: vhost_set_vring_addr failed: Invalid argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: unable to start vhost net: 22: falling back on
userspace virtio
vhost lacks feature mask 0x00000000000000000000000140000000 for backend
qemu-system-aarch64: failed to init vhost_net for queue 0
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 2 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 3 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Virtqueue size exceeded
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid
argument (22)
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost_set_vring_call failed 22
qemu-system-aarch64: Failed to set msg fds.
qemu-system-aarch64: vhost_set_vring_call failed 22
set virtio-scmi status to 15 failed, old status: 15
qemu-system-aarch64: 9pfs: xattr_fid_count limit exceeded (configurable
by option 'max_xattr').
qemu-system-aarch64: 9pfs: xattr_fid_count limit exceeded (configurable
by option 'max_xattr').
qemu-system-aarch64: 9pfs: xattr_fid_count limit exceeded (configurable
by option 'max_xattr').
Received response 7 (RLERROR) instead of 121 (RCLUNK)
Rlerror has errno 28 (No space left on device)
**
ERROR:../tests/qtest/libqos/virtio-9p-client.c:280:v9fs_req_recv:
assertion failed (hdr.id == id): (7 == 121)

> - What is the errno being printed *before* the "assertion failed" message?
>   ("(hdr.id == id): (7 == 121)" just means 9p server responded with an error 
>   response instead of the expected one)
> 
> - Were you running the tests in a Docker environment or something or just 
>   plain locally?
>

I saw the error on four different setup:
- On a GitHub runner, using qemu debian container
(tests/docker/dockerfiles/debian.docker)
- On WSL2 on windows-arm64 (which is a full Linux VM).
- On my personal x64 machine, which has nothing funky (ext4 filesystem,
and no containers).
- On a GitHub runner, without any container (see end of this mail to
reproduce).

> - Does the underlying host file system support xattrs? (might matter if it's a 
>   local backend test that's failing)
>

In WSL2 (3 fs):
cat /proc/fs/ext4/*/options | grep xattr
user_xattr
user_xattr
user_xattr

On my machine (2 fs):
cat /proc/fs/ext4/*/options  | grep xattr
user_xattr
user_xattr

So it looks ok.

---

Finally, and for sake of science, I reproduced the issue on a clean
GitHub runner. Please follow the README here:
https://github.com/second-reality/github-runners
Then, connect to an x64-ubuntu24.04 runner and:

```
cd qemu && \
./configure --enable-debug --target-list=aarch64-softmmu && \
ninja -C build && \
./build/pyvenv/bin/meson test -C build \
--setup thorough --print-errorlogs qemu:qtest-aarch64/qos-test
```

Any chance you have another machine than the one when you ran those
tests to confirm it works on it?

> /Christian
> 
> 

Regards,
Pierrick

