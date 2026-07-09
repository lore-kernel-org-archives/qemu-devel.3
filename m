Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042AAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 19:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whu0e-000223-OB; Thu, 09 Jul 2026 15:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whu0T-00021K-AX
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:01:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whu0Q-0003VU-M9
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:01:57 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HWvUA2514897
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 19:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5UeyxvW5cl6nnCwqonQZgMIvSG8dVAlE5MEv33rGWK8=; b=A2YsUVRMyHXBAfJB
 ydC4LG1973Z4wdiAOOpB5vFPiXwIdjFnfMbM5OmsZHVndr4lVjUXcA2JyLOASg4f
 lWKFFyWZuu/dAVypqOoYeKhhfaEVt0/nXWyer96M5AC2dzuHfypUxDXmi3FPAifq
 eJPYGzrwPrMZuKA6O5QkjG0IUYav5QKu1FAjYbBksGBzJgW76cXP7BnE7C/6sVU+
 aD/kbCVHzFFIARVPnos3TiYcA50UU7Q6py6E2fDKuXuhQeo3nsZFv+najmtMAi+q
 Hp15kCCFju0BEYWUCR92zPWhzR/g+YMlVFrZxRl51UpclbcgGc5+yw4GZLEx3sKt
 J1kj0A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa418m1rs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:01:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38c7e26ecabso196371a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783623711; x=1784228511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5UeyxvW5cl6nnCwqonQZgMIvSG8dVAlE5MEv33rGWK8=;
 b=VPnxUKGl9UouN8eNPvtdZdan+x9/G4toaYCXg+M8eX29I33/LOW6tgd975rmzTzK+v
 ELB2vtSzuFwcX/SQ0mAt4cIaSU8pqZP3kyjRC3+oYh+60rF3xCbZkB06xkTMHZyd6B94
 jWtVgK98AP4sWPuuueTWVDMcub1bvGZqG9Un93UL30XxL02i4AsCyYBVh+FguZpO3j9e
 2Zv93w2jzPCIq1OOJArK0JSXBC4BGH+3GzDdBUr26DxqBsnOL53gr/Ile72k7tfeAY7l
 gbrUskn26+w3USgSgOs0DBDTnDaMBVlyILM/MHqZg6YUXhGzg1qnzHFvc+Ueyfa6oSgB
 c3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783623711; x=1784228511;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5UeyxvW5cl6nnCwqonQZgMIvSG8dVAlE5MEv33rGWK8=;
 b=d6vrXK7oNSXDe7VTDHsoMBPacQWOJyNFhpicpm6at04qacNFmYIcuQgCbS5tB2DrD5
 T1UlHeagqMVw++NbN45r1r9NKYW2HU9J3WR1onEtJRJmqQ7jwpUaIbRjdPc+njmmFcJc
 5Z+ST3whGNITNOqoyhhdMzaTXixpCvikY4uvYjl1ecLdujCYZnitVNxdS6Dft8SxJCuR
 kj7v7C2kZadH/Npr0p7+ee8J8ckoCNYjHRjf8uUZvyIKMW1w5toGRKoJN2gpnxfkZQLf
 U+uXcYxcce9wYl8QDVeU+NYjogVIjcQalnC73Vrg2fKskGG3I+JRjLFiYjhY+sF7Jf4j
 mCcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3VGU0lEVyQB+XdCHu12+tdSHcx6+Y4HBrh5DPUQ3HQaMhmt1MrIT8UkmEdnzHIqcq/eAMR6zFLRiO@nongnu.org
X-Gm-Message-State: AOJu0YzH468u+t2i1aGMAhCuDW1HL0KlDaSqAQ9oYaIM0I3qNY5i01fJ
 L3o9myqgPTiDalrtNqnzVPFLrjdKQO8/eaqvHmw3z0y45Nt59LtiqD3M5hdljDydkas8pft1Qpi
 ax7UrHImvaFY9vro8+51S0r2+7Lh7U5JNMUBFVP8eor5MOECd5ygppJeFSA==
X-Gm-Gg: AfdE7cmSMnJFIafmoJrLBLw0qbswol0ellmdjiGvZAGD6LD43wLCM/tHaQXixwRMV7M
 JW2+u9koLdNAoKWWI/SF2KaZDEIDLE4FjNeL/VDX3ga866SM+PLtyoTF5rHOARF2EIDeYXjFZtx
 ptd3syZJ6RL7XjbM7Q7RsDRbCjMhsbgjN1uxPHSo8iWbN2EyzcIpAQbeGD3gngt3/EJUIiceNa0
 Vdq+jepjhpzEdjStlrp1ZewO1WIidJSyZ7Mou/QkX7AZByhqhxMohJxxqcyfeQqX8VEy8UFLfcB
 QLU3q37NjWuXN4x2yYc4pei/eyCLZtWSlPJjNYt2zpOBa0TT1or0sXWqCWUtG4oLDfaXqt+7WLY
 klSNSXW3U2vfoT2OBWS1Gc4CZMLQzpVmMDHRmjZOM/qG2b6LDEQksNKHRDvS3Yn0zHYTCjq4HPT
 zQzXU=
X-Received: by 2002:a17:90b:4c10:b0:387:e0db:bc2d with SMTP id
 98e67ed59e1d1-389421a4f5fmr8308646a91.35.1783623711293; 
 Thu, 09 Jul 2026 12:01:51 -0700 (PDT)
X-Received: by 2002:a17:90b:4c10:b0:387:e0db:bc2d with SMTP id
 98e67ed59e1d1-389421a4f5fmr8308577a91.35.1783623710622; 
 Thu, 09 Jul 2026 12:01:50 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f596asm33478635eec.2.2026.07.09.12.01.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 12:01:50 -0700 (PDT)
Message-ID: <2d3832dc-5714-4dd6-8e4a-4ff7c8c5b424@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 12:01:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] docs/about/emulation: document the dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260709025528.300019-1-functioner@sjtu.edu.cn>
 <20260709025528.300019-3-functioner@sjtu.edu.cn>
 <3954a5e4-32c2-4f89-a4e4-4b445e52589a@oss.qualcomm.com>
 <0903b004-c598-49f1-ab57-55799abbb890@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0903b004-c598-49f1-ab57-55799abbb890@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UI3t2ify c=1 sm=1 tr=0 ts=6a4ff020 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=jQIij1hyAAAA:20 a=IlNb2fE1D_EgsWQvCfgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4OCBTYWx0ZWRfXwkt21KV6tnOH
 VjKCOxx5WLsVaxEzkanAKHrlQ7Cq3a5fGHYqzRpunT8m4CJywZKvCxhsd8CRoieW6MrEvo1ZHXz
 wnZPk5zTDqEY4UasC3fRgnrEELh3R42ASg1iUoZTUCKj7YkU9Cq9H64k6++WXZ79SjF2lnlFE4A
 RTG1bH4dEjHqM1fu2z2pvDFQL+Q6F9040rRP0rMW3yEjXho7YpKgJb8jH0NgHnqj33ni8Wzkl77
 Zs6xBHUGILO6ezw/GKu/myG1sNZ59+VPiTg70+1/IwcX1saP5LiCGkY64U90v9lUOkxFakQZeaU
 yEhjeDqgGASepmsk1DHD1+ekOtEQSqbQi5vv7VBXQZev1rCRhT0N49Cs0bKHVh69qU04NvzdwX2
 d1cVOsXiq5XsNFPjlZE9FT2pHsaOoMnhcrjHLImu9x9jM+pMRuvDogEcO4WBMHzxuOsqoUa+0II
 mBvk51/3C1UVdvXCoRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4OCBTYWx0ZWRfX4ymyFd2IIbfy
 tdr4O1q3Go6gscn+mtSxtR/G4XAICNiJTGi4fLYAPPebLNUNLxRABUZsYe22vgy7jh7HP4cevQa
 Z890rCuwmwTkqaylqxLIs/zezxKsa3o=
X-Proofpoint-GUID: 0GuOvwi2qUVCKLWpmVi9Zyi2BTLCaso8
X-Proofpoint-ORIG-GUID: 0GuOvwi2qUVCKLWpmVi9Zyi2BTLCaso8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090188
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

On 7/9/2026 11:15 AM, Ziyang Zhang wrote:
> Thanks for the detailed review. Replies inline.
> 
> On Thu, 9 Jul 2026 10:29:48 -0700, Pierrick Bouvier wrote:
>> Please remove the cplusplus part, we don't need it here.
> 
> Will do, hello.h will be plain C. The guard was there because the thunk
> generator parses the header as C++, so without C linkage the generated
> guest library exports a mangled name and the drop-in fails to resolve
> hello(). I will fix that in the generator instead: it will wrap the
> header in extern "C" by default (treating it as a C library), with an
> opt-out for genuine C++ headers, so the example header stays clean C.
>

Yes, we can have a parameter --lang c|c++ for makethunks script to solve
this.

>> No need for fflush (same in hello_host)
> 
> I will remove both. One caveat on the host side though: dropping its
> fflush is not really recommended. "hello from host" runs in the host
> process, so it writes to the host libc's stdout buffer, and QEMU tears
> the process down on guest exit without running the host libc atexit
> handlers that would flush it. On a terminal it prints anyway
> (line-buffered, the newline flushes), but once stdout is redirected or
> piped it is fully buffered and the line is lost. So with both removed the
> example only shows the host line on a terminal.
>

Hum, I'm not sure to see why. QEMU or any native program uses libc and
things are correctly flushed without needing an explicit fflush.
What is special in Lorelei case?

>> Excellent, that's a nice way to see difference between guest and host.
> 
> Thanks.
> 
>> Please replace this part with a proper url, choosing a specific version
>> and arch. Ideally, you can publish under "latest" in addition to
>> versioned releases on GitHub so url stays stable.
>>
>> Also, please add a link to
>> https://github.com/rover2024/lorelei/releases
>> in the comment so people can click this and see what is available.
> 
> Will do. I will pin the command to x86_64 and a specific release, add a
> comment linking to the releases page, and publish a stable "latest"
> download asset so the URL does not rot.
> 
>> Why do we need this variable?
> 
> It is the thunk-pack discovery path, and it does a different job from
> LD_LIBRARY_PATH. LD_LIBRARY_PATH is the loader's search path for shared
> objects. LORELEI_THUNK_PATH tells the host runtime where the thunk packs
> live, so it can find the host side of each thunk (the HTL) and the
> guest-to-host library mapping, and it can layer several packs. The
> runtime resolves these itself, they are not something the loader would
> find, so I would keep this variable rather than fold it into
> LD_LIBRARY_PATH. Flattening the layout (your next point) shortens the
> paths but does not remove the need for it.
>

Which .so exactly is covered by this?
Maybe it should be a parameter of plugin itself, that passes this down
to Lorelei?

>> This still fails on my side with following error message:
>> lorelei.guest-rt: failed to load host runtime: libLoreHostRT.so: cannot
>> enable executable stack as shared object requires: Invalid argument
>> qemu: uncaught target signal 6 (Aborted) - core dumped
>> Aborted
>>
>> Seems like error message is incorrect in itself "invalid argument"?
>>
>> I'm using debian trixie (stable) in case you want to reproduce this on
>> a VM.
> 
> Thank you, this is the real bug, and the new error string is exactly
> what let me find it. libLoreHostRT.so was linked with an executable
> stack: one assembly file in the runtime (the coroutine context switch)
> was missing the ".note.GNU-stack" marker, so the linker marked the whole
> library's stack executable. A hardened loader (Debian trixie) then
> refuses to dlopen it.
> 
> The message is not wrong. "Invalid argument" is the kernel's errno for
> the refused stack mprotect, surfaced through dlerror. It read as a
> mystery only because older releases did not print the dlerror string at
> all.
> 
> The fix is to mark the runtime's stack non-executable (add the missing
> note, plus -z noexecstack at link time). I have confirmed the GNU_STACK
> flag flips from RWE to RW with that change. A new devkit and runtime
> release will carry it, and the example will load on trixie. I will
> follow up here once it is published so you can retry.
>

👍

>> Please simplify thunks/ folder hierarchy. Make only one subfolder
>> (thunks/x86_64) having both the thunks and lorelei lib, and remove the
>> rest.
>>
>> With this, we can simplify command to become:
>> LD_LIBRARY_PATH=$DEVKIT/lib/:build/host \
>> qemu-x86_64 -plugin contrib/plugins/libdlcall.so \
>> -E LD_LIBRARY_PATH=thunks/x86_64 build/guest/main
> 
> I would rather keep the current layout, and I think it is justified.
> Those subdirectories are not cosmetic: they are the contract the host
> runtime uses to discover thunks. It scans each LORELEI_THUNK_PATH prefix
> for <prefix>/x86_64/lib/x86_64-LoreGTL (guest thunks) and
> <prefix>/lib/<host-arch>-LoreHTL (host thunks), which is how it tells a
> guest thunk from a host thunk, and by architecture. The same guest-thunk
> directory is also what the guest loader reads through -E, so collapsing
> the -E path collapses the discovery path with it.

The same thing can be achieved by looking into current LD_LIBRARY_PATH,
without needing another env var for this. No guest binary will link to
lorelei shared objects, so there is no conflict to be expected.

If any library name clashes between guest/host side, just rename things
directly.

I would like to insist to see LORELEI_THUNK_PATH gone and that we rely
on LD_LIBRARY_PATH only.
This way, it's clear what is consumed on host side, and what is consumed
on guest side.
Having a magic variable forces to read Lorelei sources to understand
what is going on, and it's not needed.

> 
> Merging the "lorelei lib" into that folder has a second cost: those are
> the runtime libraries, shipped once in the devkit, not per thunk. Thunk
> packs are deliberately standalone and do not each carry a copy of the
> runtime. Putting them together would either duplicate the runtime into
> every pack, or mix runtime libraries in with the thunks so the scan can
> no longer separate the two.
> > So the second -E entry is not redundant: one directory is this library's
> thunk, the other is the shared guest runtime. The extra path components
> are the price of that separation, and the existing thunk packs already
> follow this layout, so I would keep it. If the two directories read as
> redundant, I can add a one-line note saying which is which, but I would
> rather not collapse them.
> 
>> Also, in lorelei tarball, why do we have /lib and x86_64/lib that have
>> same libraries, but with different sizes? What's the difference?
>> It's confusing.
>>
>> It seems like x86_64/lib folder is never used?
> 
> They are two builds of the runtime. /lib is the host runtime, native to
> the host, loaded by the QEMU process (the plugin dlopens
> libLoreHostRT.so from there). x86_64/lib is the guest runtime, x86_64,
> loaded by the emulated guest (the generated guest thunk needs
> libLoreGuestRT.so from there). Same names, different targets, hence the
> different sizes. x86_64/lib is used, by the guest side. I agree the
> split is confusing and will make the layout and the docs clearer.
>

libLoreHostRT.so is in both, so I'm confused about which is which.
Thanks for clearing that also.

>> Please remove the section above from the doc since it does not add
>> useful information. Also, we already have a link to Lorelei above.
> 
> Will remove it.
> 
>> We're getting closer, hang on.
>> We need to have a simple example that is functional before being able
>> to accept the plugin.
> 
> Understood, and the executable-stack fix above is what makes it
> functional. I will publish a new devkit and send a trimmed revision that
> addresses all of the above.
>

We'll be close from the final version with this. Only thing left will be
to clean the layouts, disambiguate files, and eliminate
LORELEI_THUNK_PATH to rely on LD_LIBRARY_PATH only.

> Thanks,
> Ziyang Zhang

Thanks,
Pierrick

