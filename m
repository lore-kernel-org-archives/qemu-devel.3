Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC03C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9NCX-00008o-Fe; Wed, 23 Sep 2026 09:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9NCI-00006j-Lq
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:39:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9NCF-0001rU-Da
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:39:40 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NDLqO63842692
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wiyJWc/9yauxvb/f/uF1UZcyIoXgS5fY5z4Gc3lkYFQ=; b=h5jy917nUMJigv3/
 p/2yGA2gMNqaR7YPpOwTOPH/iWtxbbmkIv1TwF5HxrDXZiEfYYmTZp8wwE4oQcFm
 43b8cKf1r25rV7ehEEanoL4MDYVMvhRMw7qidQ7mvynnkGb8JOfSX9KubxGe8Dc7
 gHG1/tEnOdm7tvHnG5yp4QLfMEGfAjDSQ8exum1rhjlD16UQx0FM+RX1njGwiT5J
 L/rhqyqiTblWAym4PnzyDHHwwNgTpdQrlZOV3/j6xyRMT1noERf7yfH8FYRep2fn
 Xh3NEPUa09UuPclT8lvdH+lrRJkDUiiHZZ0zEpwgHZd91eQG012vVmD+Tw56V/XS
 ljpe7g==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfkbg25n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:39:34 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7930cb5cd3aso795560137.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790170774; x=1790775574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wiyJWc/9yauxvb/f/uF1UZcyIoXgS5fY5z4Gc3lkYFQ=;
 b=L3C/32CaJXvPmmTRPkiChjf/rZSK569UnWgegnR9cFczjzL1zYgYh82JPTq1Y/OkFg
 E7P1STQqLOmgeW4I6kGJeMjSEVobxHX7D6ZRcmPeRLH/9nO8ciQ2KynRGCLYyDDdzboX
 MsqOW/gQppdQazUncr9VvEjlRM/hnLhJq+A0fIEM7X/XtjXXafDRXvcHUL8SfnHUn4GI
 NwNzhJZgAhch6VNvdCTJ4tVk4VBNn0MBeFT9dU4FRQt4B51RS3N2gDak93QiP29Gi3Gd
 pSXImxkxPHQcw1iknUWC8d6khOgDlTqVfZ/Qw7LfcFx+GR9BvPo1Eq+PiBZZ4gfwCtbd
 SPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790170774; x=1790775574;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wiyJWc/9yauxvb/f/uF1UZcyIoXgS5fY5z4Gc3lkYFQ=;
 b=2KEH2x2GPkn5Fh2ghmWiOzzununJGcTnZAbcCQ5X5syYMsV9c4EqF1+Uia0aUGyVPJ
 MZchKH1JOgPjGGmX2+uU6q8MKvFz3XbJkD+VbuIaa7TOxHYr0nh0mSX9ZdaAv8Hb1B8V
 hyM7CaqlKnV9albFtDp5f1D5PkahTx8wkDror907T0284jl9d4Z3AcaB9avK4sWdT34y
 wA8bNu6HiBeyf7p56gohd7bf0SgAEPeFDFmkKc6oiMqvfSZdLFml57PG4XNsJDX/chlx
 M3/GMJrkm6CWK3Sna/WpsYPHeelnXkwNsf4x/OK9Iin8W2z5RnYv+19Dbx2gLkbqzbZd
 pleg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRa/BIuAY18ndt4YwuukbJZ07P0EYLXUrYtMVTtOOIjKC3gIaGwO4cykM1++xccVpryx8qEooXrXOq@nongnu.org
X-Gm-Message-State: AFuF++nGKii5FS6etTL91xWHYy0JT/O/xL73f7sggCi76GrfrjxE/96N
 JhnH0u14pRV89kKYb6+9U+fYulnpMzsfmYwzM2qqryDLYXmtgfy63WAG7zlc4/Z7DS0egwriMu/
 xkp7QmAXZMVekTQEYcuhSvpkeKbJIxBtO5u2jVgUdoZRTh/hrTuFhMzTF9A==
X-Gm-Gg: AYBFou2EI9p1UjxiGIt8rOcg8arkO4x2tAOh+64Vutkmm4ZnNNWTFo//nNPNWScXTWa
 vix3hKghKwkyLZPtr/m5SuA/+Mme9xCQhtXzNBK1y9C+qJtITne0uRhlSNTS0o9RmgNL1QqJBE0
 KBMKarpUOHlsQRDzgwXuCq27XDW345maaA+dmNWs8lQKBzrdkjBBp7CJHt1yjSfLhsOv6WpGXdu
 4PIBvc/4p0kaZRgGdRZ0Ta2WZ1sOAN+0nRjOeEqWat6R3GRsutJqLICE9+uEPsmRqz+a+RjoEkL
 3jJs7U3+kqVAnUThSOw0T/T2JU89HKMdpAriPZ1X63Qt0eT1Fn+mQGC1EAd7vX41Oa/0j+PpTHR
 6hVmQO1DjxHTptShkWrI3JvXakNZIcfbrR8heuTY=
X-Received: by 2002:a05:6102:f9d:b0:7a1:f7d2:e820 with SMTP id
 ada2fe7eead31-7ac1da2d3b2mr2516463137.25.1790170774095; 
 Wed, 23 Sep 2026 06:39:34 -0700 (PDT)
X-Received: by 2002:a05:6102:f9d:b0:7a1:f7d2:e820 with SMTP id
 ada2fe7eead31-7ac1da2d3b2mr2516427137.25.1790170773609; 
 Wed, 23 Sep 2026 06:39:33 -0700 (PDT)
Received: from [10.21.17.122] (46.170.88.92.rev.sfr.net. [92.88.170.46])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1d978fsm70326845e9.9.2026.09.23.06.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 06:39:32 -0700 (PDT)
Message-ID: <bb91d62a-f15a-42e5-813d-5ec7e6d92479@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Stop vCPU thread before calling
 parent_unrealize
Content-Language: en-US
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: sourabhjain@linux.ibm.com, rathc@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com, adityag@linux.ibm.com,
 richard.henderson@linaro.org, mkchauras@gmail.com,
 sshegde@linux.ibm.com, srikar@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260923121444.154175-1-shivangu@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260923121444.154175-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NCBTYWx0ZWRfX3LVQoSiECtvR
 vKm21xKGBUPXT40WwiPF05YAxxn84PoLCrB7nY/YXZesJUR1q3v/50ppRyrya3squDlb1Nl/mrC
 SUvB/ZlqMWK2pcLP6B2fonM3VzT9fy8=
X-Proofpoint-GUID: xHY1zgSwpno5p8ZndOzIy2g-kXvh-oBz
X-Authority-Analysis: v=2.4 cv=RYMFmFtv c=1 sm=1 tr=0 ts=6ab3d696 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=+jeclGPz5oz7OCF6/fgcyA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=dZLN7GVSkI17RpY60RsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NCBTYWx0ZWRfX9jncPGgCwmZv
 CPvZaq4+0cEBhMKp5EZVmPAVvIJeVn2HuFsizZKioUpr4l5DF2iniviS6zG4vjvntvSD8VoSqWO
 w+DZqxZ47fycZgnPE/iTpEwwWqcY2ltOVURaDwfX/qrRSoEHc/pXMeflvJttZFfWHR28JE/xpBy
 x09T2FlEpitWaHqSQW8FzLYTohU2xveYd6vvkvfSvZLbwRmpcQFfyAtsh2xEJvsTgE/5kXT3FO/
 oAKQ5QW0drMIGwf1ZB8vmWwrdBzyadN4K+d2wOIl/SPV61kH/s8hSssHkY1vtQiJmp3446iwPz/
 +I6/YBKiqxZlwGfDYn7SXhehQYV99HY5B+hlQ8wrxxDnqaj1tNeYAKweOiV4NSfTbkv+3v9TVJ/
 o3i+YQgFu5sc14J+l5Bt0PE2aSNIYm8tnbIsna4YEz9Z6bERWcHUO1pBfk/1/EZPoPWa2P8TIfl
 5SKDsxKEaoDMKrXDKFg==
X-Proofpoint-ORIG-GUID: xHY1zgSwpno5p8ZndOzIy2g-kXvh-oBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230054
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

On 23/9/26 14:14, Shivang Upadhyay wrote:
> During CPU hot-unplug (e.g. via dynamic reconfiguration unplug),
> ppc_cpu_unrealize() invoked pcc->parent_unrealize(dev) before calling
> cpu_remove_sync(CPU(cpu)).
> 
> pcc->parent_unrealize() calls cpu_common_unrealize(), which triggers
> accel_cpu_common_unrealize() -> tcg_exec_unrealizefn() -> tlb_destroy().
> This immediately frees the CPU's TLB tables and structures. Because the
> vCPU thread had not yet been stopped and joined via cpu_remove_sync(),
> the vCPU thread was still actively running its event loop and processing
> queued CPU work (such as tcg_commit_cpu / tlb_flush).
> 
> This resulted in a race where the running vCPU thread accessed and freed
> already-destroyed TLB tables concurrently with tlb_destroy(), leading to
> Segfault (due to heap corruption).
> 
> AddressSanitizer build reported a double-free:
> 
> =================================================================
> ==121930==ERROR: AddressSanitizer: attempting double-free on 0x7ef8f3438800 in thread T14:
>      #0 0x7fe8f74e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
>      #1 0x7fe8f6cb8f84 in g_free (/lib64/libglib-2.0.so.0+0x41f84)
>      #2 0x558bf6a391b1 in tlb_mmu_resize_locked accel/tcg/cputlb.c:249
>      #3 0x558bf6a396b5 in tlb_flush_one_mmuidx_locked accel/tcg/cputlb.c:296
>      #4 0x558bf6a39f91 in tlb_flush_by_mmuidx_async_work accel/tcg/cputlb.c:390
>      #5 0x558bf6a3a200 in tlb_flush_by_mmuidx accel/tcg/cputlb.c:417
>      #6 0x558bf6a3a22a in tlb_flush accel/tcg/cputlb.c:422
>      #7 0x558bf73f31ac in tcg_commit_cpu system/physmem.c:3068
>      #8 0x558bf6987c55 in process_queued_cpu_work cpu-common.c:378
>      #9 0x558bf73a9913 in qemu_process_cpu_events_common system/cpus.c:402
>      #10 0x558bf73a9a46 in qemu_process_cpu_events system/cpus.c:421
>      #11 0x558bf6a65974 in mttcg_cpu_thread_fn accel/tcg/tcg-accel-ops-mttcg.c:90
> 
> 0x7ef8f3438800 is located 0 bytes inside of 65536-byte region [0x7ef8f3438800,0x7ef8f3448800)
> freed by thread T9 here:
>      #0 0x7fe8f74e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
>      #1 0x7fe8f6cb8f84 in g_free (/lib64/libglib-2.0.so.0+0x41f84)
>      #2 0x558bf6a39a91 in tlb_destroy accel/tcg/cputlb.c:345
>      #3 0x558bf6a16354 in tcg_exec_unrealizefn accel/tcg/cpu-exec.c:1094
>      #4 0x558bf693d073 in accel_cpu_common_unrealize accel/accel-common.c:117
>      #5 0x558bf6980e37 in cpu_common_unrealize hw/core/cpu-common.c:279
>      #6 0x558bf6980dfa in cpu_common_unrealizefn hw/core/cpu-common.c:267
>      #7 0x558bf763ef65 in ppc_cpu_unrealize target/ppc/cpu_init.c:6965
>      #8 0x558bf7872199 in device_set_realized hw/core/qdev.c:618
>      #14 0x558bf756068f in spapr_unrealize_vcpu hw/ppc/spapr_cpu_core.c:209
> 
> Fix this by moving cpu_remove_sync() before pcc->parent_unrealize(dev)
> in ppc_cpu_unrealize(), ensuring the vCPU thread is stopped, has
> finished processing its events, and is joined before CPU resources
> and accelerator state are destroyed.
> 
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   target/ppc/cpu_init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Good enough for now:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

But long term we should move the call to cpu_common_unrealize() IMO,
it shouldn't be called per-target.

