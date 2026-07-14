Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1141C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZbr-0006UE-57; Tue, 14 Jul 2026 05:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZbo-0006Tl-UZ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:39:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZbm-0001TY-Sx
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:39:24 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E7YIXI4101750
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hWzXw2dWJ1ciDFV+5kF6s1a+r2bvFQ934UQSbfcna44=; b=CmPLcjAVepV4iJdC
 WbKuvbnhXoibwNYjmzW2hIoqkDsmcqk/4H4lyNZ/EENl2su16RlFyv9gSBQmcsdA
 l62pqEIvr+eDhGGqd0uhQzVO73d0jVrVTtbEXLajcl+MYbiXxWH4gqhTTl86pVLb
 hjjh1dWuVubz/PzhpPv+gIfgrXCxt95A39t7zFHy5bRJbUKqGkaTyX5yCiJsAXcq
 LTBEfWQHvyBiH7KqnLMhgZEqPuOP2ujwBRVDl1XjV5E3/XFNz0w2Yu9v810O9q1x
 hCppO85xXq5/h2Z/H6dkvhsRC71ypSW230f8IOkMpMjJGc7StqNPSt7dcuSG7Xrm
 EW+X3A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgudgf8x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:39:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8e9b9f30d65so57002106d6.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784021960; x=1784626760; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hWzXw2dWJ1ciDFV+5kF6s1a+r2bvFQ934UQSbfcna44=;
 b=iQ/tEW5qsESPSLYIXFQYKBTHdG5L3WJTRKuS52lz0s5A5kng01SKrLO/xYW91VWXNz
 0iYlDC6Stsu15OIEhSd3/MAoR7yPz8yk6lKujP5eIyEd9lKOXqQkAuLIumOTWgUBaS3h
 HVfAOV5Wi2Wz8/zTNzLjF/GbnrzQR64LN4j+Ar/Yp7YHgco+o2SvhecmqCz4q+lKaaFi
 fqyDGR2p2kkRiosX3viRuX3+5ts6cJ5ebQ/jkD97yLqT9o/v/bhyjcOiCq5hdzpRcZjc
 RV1pDUItjEk4xg6bVAaLzyob00tcOWjqTxbU/zcaHPX08t/PXsWqQbW2dNNrsQhUBETO
 FzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784021960; x=1784626760;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hWzXw2dWJ1ciDFV+5kF6s1a+r2bvFQ934UQSbfcna44=;
 b=lN1b3xOfZ1lKJs+3b/qQivF8bHeG1V1IKnVLrxmm7a3iYbgfRpEmZ3O36pKb8cG4OJ
 Tj8JT/kC9G+49hD/6O6VZ24Av965fpXF8Mt5SawBnjkmoWrSLEKBA1Y985U4NXa7jmGR
 KsqPEcUWqYrDsp5whGD9yLQx+FgHuAlpY9UVe5JJmQJfQ1iHUkHlRlUfldxk03jBPLug
 bzYK69xaVGc1YOFRmvXIj9D4zMluONJtRj4HrX/c9Mp528TyZ42z9o4QKsEt9pT9BAAx
 jGo1kbUvL/jKsNRQJ6mOQY/NA/Z06xkMkaSchTF09EPanvYZz4oJaqx+AOri1kWcz3OY
 vJ+A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9NoAl7dQeQhTmQwWwQH7NHj0ghXwpDZuM1Pzqr0qdZ2cJfNAPHDiNTIrf6C6E4L+RtR7UfCoDOszn@nongnu.org
X-Gm-Message-State: AOJu0YyQF/rH/FxnmA9zW962h5gFhSizYP6e0AajB9wAvwv9gydoMgmf
 83Pvwj+TJ0abFHh7+uWoTLLGI0CAzJUdX/Ua7avc1yz5uRLvvwxkzqbMu55F5ggDnL7NL3BTNoK
 j/5gQnfjSeJKC6p+7Omo8SOQiLvX/RF3omm9LxcnIPOjCSeVKqqu86wyg4A==
X-Gm-Gg: AfdE7ckIXgduC3zJd9Q60KXSlF+Om/qQ5Mza0bnZeUuEoaVgvm6AT8C1OYCwElgqYen
 zixWR0nUn9geqYTg4DSv0UPKCwyrcAzM7dCbqTQ90hf4m5/qyc7/fnWfeQNoT4lgU1CVjV6nbj2
 8hy51MEQ5EMdsKzSL27CV0h419vaqpGjIRmnGYG6jtUYXwfyjeZuC/2jGCCmHdY8bpAnuEl+Gle
 6dO+T9oGTDqrJk6ObxlTMlwCzpxw9dJIDNaVfuHH4b20fK1VSOKW0e0vmjuu9rXkAKQ6pkktGV2
 OkivvtUdt3+B0rGTSlEN6QCl1G6RGYWjLtUX/aBLRzGfjAd9FXuY4U5j2YAZ/xV55E8fxXJhZnf
 LvMbY4jsEVTeYbUGTseZ5lRUZtwIDoH3ty7PPH3B+RcmQo7GA3AWDejPvBzyVsw==
X-Received: by 2002:ac8:7dcf:0:b0:516:d60f:6438 with SMTP id
 d75a77b69052e-51e42167a28mr11213651cf.0.1784021960066; 
 Tue, 14 Jul 2026 02:39:20 -0700 (PDT)
X-Received: by 2002:ac8:7dcf:0:b0:516:d60f:6438 with SMTP id
 d75a77b69052e-51e42167a28mr11213451cf.0.1784021959469; 
 Tue, 14 Jul 2026 02:39:19 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15d0c3cf1esm896160866b.44.2026.07.14.02.39.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:39:18 -0700 (PDT)
Message-ID: <43e77c9f-0628-4494-837c-1d3cec1924c8@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: fix dmabuf_fd leak on remap failure
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260713125622.111513-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260713125622.111513-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Xha9no4PhGGDaD00MmdcL68QPJlWrAlX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5OSBTYWx0ZWRfX1lHD19Qw40+S
 J2P2oiaIelay0N3Tns2tb0TkcKAsTXoefdwj4jDfsvI0bGl9X3e2aKiIicJHciKlUESuCqLYKv6
 C6C+yAru8p+aLnkF9qqSB8fUCVsAJN/Ty7E2+8T9iNJX2W0cFb8pTH2rpDExrrjbZ1j5UVYcDZI
 mptdTeEuPg/k5pBIfn1JA/HyrLqmebHXxE/HXwhqv4EKGC6YAx5INOrpPHlnWnA6Pt8UCJqcuXK
 dFdHOeVy9HBdv07W3bnsGXyN49zUQea6DSqeYjL8S3E2HiHXKE/JQQcoGB4ldDs8dclVqylUgFA
 p3yN0Dou7IMuf114ct1yUCz1dv7e+DJAtC//yK3OsTZkrw8j8HVpvtgmATKuD3twAs0DSNpU4L5
 iV/1nhEpDuFVKpkb/S7gC0PdkJJAkoL8cp2dlZvs98X2EnNt4kCbO0Q22QGXcCielGEEWeAZw3k
 P48nrIYToEu0C638aIA==
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a5603c8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5OSBTYWx0ZWRfXyRpxb4ml1ygF
 opQHBqhF+Cv37nGkcxEbMaynf10BsWYQH9uqXLsFuqj4n/i6P1od7c428h0wGa7Gne33TQ7GPXU
 o4wuGNdrm4sZb3FvsFZow6kBhftEj5k=
X-Proofpoint-ORIG-GUID: Xha9no4PhGGDaD00MmdcL68QPJlWrAlX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140099
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

On 13/7/26 14:56, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When virtio_gpu_create_udmabuf() succeeds but virtio_gpu_remap_udmabuf()
> fails (mmap returns MAP_FAILED), virtio_gpu_init_udmabuf() returns early
> without closing the dmabuf fd. Since res->blob is never set in this
> path, later cleanup via virtio_gpu_cleanup_mapping() skips
> virtio_gpu_fini_udmabuf() entirely, leaking the file descriptor.
> 
> Call virtio_gpu_destroy_udmabuf() before the early return to close
> the fd. This function already handles partial state correctly: it
> skips the munmap when res->remapped is NULL and closes the fd when
> res->dmabuf_fd >= 0.
> 
> Fixes: 9b60cdf98723 ("virtio-gpu: Add udmabuf helpers")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-udmabuf.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

