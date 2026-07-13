Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E6EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEDy-0002J3-2x; Mon, 13 Jul 2026 06:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEDw-0002Iu-Jr
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:49:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEDu-0003bG-TZ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:49:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D77VYw810653
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 26eLwwVYgo8GXeLIeFihBOPMedhPwBdUrKO7kSfFNTM=; b=HvCDYh1PrUSQDl/e
 igdkV2g8oYUY90gJ+EUSUtTgsY5rXh1L1mDpLAfEW7CX29VDvGrnX2mxmfmvCXqI
 8JTcCCph6bg6FC14l17R8bjSQVrHbygfE9PFXa7YHGXRXLEt1P5IsKD0GC68hoNM
 UUzWp09rwGeUTQirFMHaHeyDDIqymnFvuW8f2Kh1+aJ+HYvJtFBSLkUhYcaKnxAL
 q/U3cipXPbF09+6T4dfIv0XkUUGaoVS831xj7kLN+gVM88ourwOlOoYYZ+xWbyue
 zqK9NWnq8OrRBqFnHojmSI9PjW7GMU2eVgwXO5CEGSDqRwBCoiQ35U2lLgj+Dowl
 U7sobQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcubsrt90-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:49:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso41683101cf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 03:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783939757; x=1784544557; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=26eLwwVYgo8GXeLIeFihBOPMedhPwBdUrKO7kSfFNTM=;
 b=Iv3B11QZ9BSvkEw+Aq5yt1/FRSO9l7PvuRUJr8gn5HnwMBTUYdYtQKZV/Q+76zMmQV
 CkwpFVvGVKy0u2JB5/C+Ol/7g2q3sDP1aN4EAOJltXIIc8e+vUpT0fnbqh+Tj8a/Nq7q
 DSJL6bHUVVg1VuCLLjzuEYXeYpqktwO1RsoLhvW28EJc1WzHOJN8kdgj2vionz2Im1CT
 GjLYIKguj1rKkxTDaB+sHgbzK8+w+K1hgw9A/RkXXTc/HFDfoTwTkRF+GPxVTh4dBhtZ
 Hz+IEWPZfBacXnROvVdWcqbmjAqcqskNU2p37Gw0Lrtwyl02EJnIXcsejv7KGIxSCwsv
 Q7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783939757; x=1784544557;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=26eLwwVYgo8GXeLIeFihBOPMedhPwBdUrKO7kSfFNTM=;
 b=CgqVuwrWBI6ZRVExg6fwqNL3UYU2oY/G+k2XF0BnqZEzOv+/VQQlMAOumSxQQGSahJ
 nxQnM1nomYOVnCuowV+gMD3Qg3Yf982tsaGDnqk8WbC2gkRvup88rRGkgnrlwlIDMSld
 Ag6JvYGofVP0khDtX+MLMdW67gnuzgsqU1JSqgAXkuAvs+xunn1W2uYua9E/BK6xz6wu
 V3oqV2A2Mn8Xqd/3k+gPdS2NmTYCZ8HdMCX+Gf4uvduFRqif2rkQ4Pw61KMc4a1w8diw
 26DEoFsng8KDmxLBXNRHh8x6yAFgv7oRwTmdBepCriQYDotrK3kkHaBvW/FlmEHDpxQu
 nUTQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1ANMAFWb1jHriE0AUUq3m/I0Kyuvj3yD4OxPC0/ynTlzgEjjBJ6Hgk0j7YrTSOfYArtv7/zq93gau@nongnu.org
X-Gm-Message-State: AOJu0YwkbqhavOAALD3hVARrPWajL37H1xhgbNlRCBhFQ6DfsHcBcDsK
 BG4KmKXp3L1nHlA4HBsUdxi+k+axuVYtPMHx0PMixVJpORTA78w1rRthfwOpCJhxayvavArMm7C
 sJBn//MiaUh26eLnt/rCQKVnqlwNqJ5O8YmbI2tQcwQjOKTutr8ksSMRbTw==
X-Gm-Gg: AfdE7ckVFevGf1S6vyVuw0ds2HDOJ3lpqd+BDty96n7FD7oMXdu0KtDPu57wiLVsnZz
 /X4et86x45l3digq4r8FImChtXX2AEov1RIUOBgrHPEqOUBqkfIcMl/Rmo+9ErPfpZpTy+kaYp/
 1YjdElftHABkNDRwhpwebc73uNiBHUf3zVm/DME/HYuDF7iiUFcj3YLYM00kLwYykGvYaZj1WCD
 eyYBEJTwNFvPqRctxYUBFXKIOp1kNufy6AsgkZE5xKPe0YN932ZwYMPQdDIHQctnz2ViM8n4/dV
 m14jJoaETd0EForMcNPeSiTQJDY3CFdneRGGQ/Bg9x1+549gg65EsWcZLPJkrUGM0g0MB1cdlAn
 WKlKapNWwe/9WJWuIJOBDTqTIfVKyj+9zIBIkfiArh2xVRjWS9w0rgYAQOhX3yw==
X-Received: by 2002:ac8:57ca:0:b0:517:9407:5c38 with SMTP id
 d75a77b69052e-51caa1280famr130499381cf.24.1783939756960; 
 Mon, 13 Jul 2026 03:49:16 -0700 (PDT)
X-Received: by 2002:ac8:57ca:0:b0:517:9407:5c38 with SMTP id
 d75a77b69052e-51caa1280famr130499221cf.24.1783939756579; 
 Mon, 13 Jul 2026 03:49:16 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69c14972fc7sm5196098a12.22.2026.07.13.03.49.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 03:49:15 -0700 (PDT)
Message-ID: <3df12339-da7f-4e10-bff9-ccf2af1f47bf@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:49:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/vnc: validate SetPixelFormat field ranges
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260713100056.4104383-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260713100056.4104383-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Oq9/DS/t c=1 sm=1 tr=0 ts=6a54c2ad cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=vCepu-6x9kWsNSnMq-MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: VmhzVEoC7RUYYQ-g9HdacnWuF9wZ35i2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExMSBTYWx0ZWRfX9Bbl53sWSSb+
 3fj9y+WmLC6iLOeh4JdQVHUmX4R22VaqLWCSJJ4RX+0JLSdAum0KKyDNIejJbL84Pp/sdneOKA+
 abRlNgupe3JGfMNLD/mJDM5hpOHw+hA=
X-Proofpoint-GUID: VmhzVEoC7RUYYQ-g9HdacnWuF9wZ35i2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExMSBTYWx0ZWRfXw6OeDn3mRv/x
 4pQrU06+N7PYg7L7dP3rHaDmV9mlEwaSBELt+BVH7IDx18Nb7fQExwNYfvXKEwVynVomsAy/rMv
 5AJntcaH5u1jv209/b16VUtR6TVsUcBBc1DmoZo0/CW7XNOKaSH5v8nM8b87Pu3KsHEshiOIMah
 lgAslaX+hmVckQ9u4pd0r3N9HDWaj49cCKOd4kIcmvO0m2g46/9W9SffLU0QOwc5UMkygZ44Jht
 WMXhojciAD+ZOR6OGbWDVtIje1M+aY1AfCOt5xgBwBvRR4qxmCXfaiJ+vePKbG2LrwJxqJ//1qN
 26cnWAMNch1KtaWf1wmpnA37ofdTAqkrrb8JOqq7CeH5EK9kZuWg40vN5gd6PPqTUfKI0FQaJC0
 pW916E3VUh7jLveVBAKAPICJXV1Nk6/Y+qCE6ga7LSUPWwmFL9fbToMcEhxD99Jd+BRakPAH+wp
 POm7kQwUzg3dEVlwF0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130111
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

On 13/7/26 12:00, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The VNC SetPixelFormat message carries red/green/blue_max as 16-bit
> values, but PixelFormat stores them as uint8_t. A client sending a
> max value above 255 (e.g. 0x0100) passes the existing non-zero check
> but silently truncates to 0 on assignment, leading to a division by
> zero in the Tight PNG palette path.
> 
> Similarly, the shift values are read as uint8_t from the wire but
> used in left-shift expressions (red_max << red_shift). Shifts >= 32
> are undefined behavior in C for 32-bit operands.
> 
> Add explicit range checks for both: reject the connection if any
> channel max exceeds UINT8_MAX, or any shift is >= 32.
> 
> Fixes: CVE-2026-15578
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3976
> Reported-by: dong ling
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

