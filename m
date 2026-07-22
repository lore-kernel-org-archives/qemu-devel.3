Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3362EC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVjs-0007RH-3b; Wed, 22 Jul 2026 08:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmVjn-0007Qp-KX
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 08:07:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmVjl-0004hK-BC
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 08:07:47 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8xLfa412319
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 12:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yUy7JUqM8JUt3SrueJnPE00gO7mDMf7KIMudqCKb3i4=; b=OjEbqvXtY8rLTTWL
 YOgNW52TpKwkuFLT0MzH51pm0qjWzShqhysY9pd+HznVehd9GWbjOYoH9ixo9vQU
 TAuaHl48d/riC22HlZzxkmTLwAl2TOpnlWdUJcfG2VmrKh2ohBV/QIQZR8z4bqC/
 EjHfJtlbayeAWQxTq0dUFkDdke1wQ0xT2YIIvBvyG5Q8FEX5yphRXQVTtJ8gMZoO
 vp0gTbRgYTUVB4z+dOR8aKOxJxAPZuOQvyQXr5SzI267XH424sIU2FR2p+xw/maR
 mji4p7KfXDIQB88NQxU0Ht9l1zpaJSC4x8ixgD/5pyBT8B5Syn9QDF2nZ1kBhXKK
 fG8fhg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjpxdhr8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 12:07:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92d1cae5939so2426434885a.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784722063; x=1785326863; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yUy7JUqM8JUt3SrueJnPE00gO7mDMf7KIMudqCKb3i4=;
 b=KxFs3PRC9G33pdXHuRHUQzz6oOglnmqEk2rkoLCXxOgBYgAUR0WBms0PEeMyn7rdc4
 wA27LdCb005qS6xE9HAE2BPRyZueY3s+MrRLXsCG5uoKt+Zun4lLd8OLYc2oiWbx/EGi
 l1s9t17TP549DKIrhuqrTl+7k+6zZeYjE+/7y9LfkDdK9facTmtyIUcCJ9IK/tTXmVY8
 LlZcerslw1ByGZfc4egX3VMeNNj77Dg8ZJV0SX80UfNRp+aL1au/+QyHoDlOVTo3f3uY
 VFdI2hcYaEW09Le1BCzpEmYf47oDB0LFWhJhpZqeVH18lXN3hCeWoL4RV3z0xbu2Txye
 Y1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784722063; x=1785326863;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yUy7JUqM8JUt3SrueJnPE00gO7mDMf7KIMudqCKb3i4=;
 b=TGTS2LN8dzOQv2GQjKFw152yV4axNLLB+rpao9dJ0aqOw40HxZb2uPAosVa04ly1C6
 rJw1Ag6lViN6qqdry6JUqOvRjASr5QZUukAa+GWkeYUN5KaPMb6HZfyL+0UWd+hTM6h7
 eLJ1zdk1MZP8Lg9HHcufiQ7/R6Y+DSJxrUeJjwfnS/dlxb/pRKSjgGDU8v1+9eb0AGEs
 k0YdEMIz5Gh5MiWW4dLuO1vZDMP01/H+E+0uDPSWMzWaWjQqNZdpmuUWLiIr2AG53nr0
 ZNnxJl2hWPEnt6b987OUYjShOFIWW2OCl/SOodmvQpT/jgr1aCtHe6LMMuOvyQydchFM
 A12Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVMU/w9PKYCcyxXfrsGH7PIEtAj92MH2jEdLFc3KBl3fZ3T94uVuqAZ8UH4EApMPZomt91a4zZDsiT@nongnu.org
X-Gm-Message-State: AOJu0YwJHqeiYcI3ZG6l7qqilHtCBgyahzprIw7G4966HkjTUxySmLwu
 4hnWpi0ifFVdwofAuomIa8aUS34dPUZTu+/g67pHLtbvWyQ3p+DiV7kRElCPhiHTSI9s4/fs6Kz
 rpbip61+sjXnitS2cgPXKroCV/nZktuAYymgX04c5gfWd7b0Bw3/Q9aMDHg==
X-Gm-Gg: AR+sD113jAgIJiqvm8ONVK7k506lN79LyEbtVjnRYQbvMQWNVre2NrLtK2G5aph7q/V
 L11Z8DsWUMWB4asEoq5FGxndOvIJLafCYzpJQXSnl94ledNI50UAaU3II8tFmn71bAN+Va3KinQ
 G+xkLZTTF12mtk1dztGS/WjmXxslA/qGjng14aGh3NFxWJ3kGjuTllGvBxNHSvu0vnI3FFzgsa7
 Q7uDaNk9QIYB/ZHBTaFCRcyxjxETsOeI7IXBwsRSMqnLDKaWrOSb2AMoPCeuOlotcKKQ7TL7Xbi
 8Eyp7YO5vpucywl1bk7cUGd0nmgnef7ZIpMFDZKKJjiYTdsAJ/Tc/fwiGwHBEYCBaQstB9hCQ/c
 9A1SDhc2jcWMCKfe/9MyFbgyd5gf0R8wA+734dqyqR1yN33WqKcQ=
X-Received: by 2002:a05:622a:1813:b0:516:eaf9:f6f1 with SMTP id
 d75a77b69052e-5213c0073fbmr213973011cf.13.1784722063236; 
 Wed, 22 Jul 2026 05:07:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1813:b0:516:eaf9:f6f1 with SMTP id
 d75a77b69052e-5213c0073fbmr213972461cf.13.1784722062597; 
 Wed, 22 Jul 2026 05:07:42 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b72fac1sm46302815e9.1.2026.07.22.05.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 05:07:41 -0700 (PDT)
Message-ID: <8271b7e9-216b-4925-9dfe-720432f88420@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 14:07:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 11.1] crypto: deprecate the AF_ALG crypto backend
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 devel@lists.libvirt.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260722115701.716516-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260722115701.716516-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExOCBTYWx0ZWRfX1K0mUx/UwKdG
 92v8ShFxsis/tdJspj19eu0KKJLfuBzTMbl5cPbsP3PBkcD6vRWZkMaeRb4OqV6ayh2thq2rJKe
 XN13Kqk7UuvDpNfDh5egzG1wx6VgGOq9QgQ94alNw6FFhtS2dh7NNS6TxZ5QtIqMS0FJDymjHRj
 K5UApjvpAb6zvffQU5IpUlEDMCOuYarBHlQdcJpdYLaEwEQwcP8j2uztbg8HwRIKoNNCb/dCn6v
 9pr6b8F9csBUT+z3hSoYj4G0TuMKpBMNtG2wqDFHCwjT0mqZiP1lNKF9CnSchlW8CExNBxLhYo+
 0hXwdrrd0tL9IhBN0utfzqq2kNAPbWZcXyWsgldYuojbjL/rnm3w2YGHIOKoARo//RONncfyZmd
 gpLkYxK7QxVefooXxhsKjA0OmQxtkqddxmRlKYhM58INO3YtZfXrn716Bfad8AAP99p2eEqmEt9
 X55qIKu5dUdoy9S0kdg==
X-Proofpoint-GUID: WcojmhfhD3BriHlrX9XnbBhJdfUHIem5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExOCBTYWx0ZWRfX576eEMp6wupN
 WdtjBEUaW7NBXpT3iQcPSmhpM0D7YGW7kWQkXSVmfBfUa9OUccpN5QLEdTnKZj13LkQnDynyBb9
 tseJVJNNdAcKDpjDoO0NFKtwdFLkbG4=
X-Authority-Analysis: v=2.4 cv=b7iCJNGx c=1 sm=1 tr=0 ts=6a60b290 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=wbFVLd3j-wu_4vr_PzUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: WcojmhfhD3BriHlrX9XnbBhJdfUHIem5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220118
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

On 22/7/26 13:57, Daniel P. BerrangÃ© wrote:
> Linux 7.1 has deprecated the AF_ALG crypto backend:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a67afb1884ba815079bd43d5c998e155e03b08b6
> 
> And has documented it to be always slower than userspace crypto:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5624ea54f3ba5c83d2e5503411a31a8be0278c1e
> 
> as a result of dropping support for zero-copy and hardware
> accelerators:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7524070f26d8d347c26787dc297fb844baa26abf
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ffdd2bc378953b525aca61902534e753f1f8e734
> 
> The main use case for the AF_ALG impl was to improve the performance
> of virtio-crypto with the cryptodev-backend-builtin driver. In
> practice this did not matter since 'cryptodev-backend-lkcf' can do
> offload to the kernel via the keyctl syscall, and 'cryptodev-vhost-user'
> can offload to an external process which can optionally integrate with
> hardware accelerators without kernel assistance.
> 
> The AF_ALG backend has no user visible configuration options at runtime,
> it is unconditionally tried with any use of the cipher APIs. So it does
> not strictly have to go through the deprecation process, however, it is
> left available initially in case there was an unexpected use case that
> relies on it which may be faster with old kernels before the above Linux
> commits.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/about/deprecated.rst | 21 +++++++++++++++++++++
>   meson.build               |  6 ++++++
>   2 files changed, 27 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

