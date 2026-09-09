Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6437FC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4PbI-0004XC-Tp; Wed, 09 Sep 2026 17:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4PbH-0004Vf-4o
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:12:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4PbF-00017I-It
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:12:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689JIJVD2363889
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 21:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TmRBrvRGbXXSbq+Xs00GvvTCj8zMY0dPwyym6mxQ0ew=; b=ZkadLm13b5VO0DfR
 zReGPKNPZJxLSeouorfzLmiJ4ciDTpQCXWGvbPHONVQFJEooACNhpqx86TGJpLIj
 wZEDleG+yEDHIOIsu+DeRmyZcIoxAQW9lsz9ZYdHAXr7ykzydHK4fZy1x+q0pGC8
 yO+rsNPFLYsEvUFUNH2HKfcYfhbFcVjORxcWZ9NFvzsdqU29G7RtYeJiy1VnyJNN
 LWaIWvAaA6neOlEb9uXlpNBXDRfhR8gLzQokqCyrXnsxwJwFQM5csbJuwo9/idzp
 XUiDsPY7r04DWEiRvTV3ImRDhW5luVAa3sryo68LmA5ctNgnuOEbA1ckUsFkRHgd
 OQXX4Q==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydrn08-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 21:12:56 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6bdbda8d453so2484206eaf.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 14:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788988375; cv=none;
 d=google.com; s=arc-20260327;
 b=Jf3LwgGVVq7ztgancWGc4Loqtondr1i3Y3YeljI/X7goRWhfHwh7lGx9XHfjDlvYZO
 xvL2frHFU7EnRSgQWJRgfI3QmQBuZ4D4DrXYjY7k1ZRwuSoqhl7vhJUJpcwAcixAqd6y
 AmRuFJdJLldzQoShyJhkaIdrKHG1tJxVH54SNzo7Np+ipqCTsCzsKejJH3m7NjNMw6QI
 nt0R9vgBw8bCkoaMNC60ntWXsjWo/FDE52vcxX9Rjc24h51vtdqgTQV2HLXzzesS+kO3
 ARBJT5XRw77S/WFAQZR35EP8mHj35intPJqkCG7XtOYoJ9YPwh1LMVXI1uNwdVm1Jmtl
 RkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TmRBrvRGbXXSbq+Xs00GvvTCj8zMY0dPwyym6mxQ0ew=;
 fh=JS/OgZbRfXQVDoN5rCEv3BGagEhB1TLJSS5HOGFUyfE=;
 b=eWySwwSmnwYPb/2Rb01VA/twBf7igH4ZZBhi9KryJKBfyuMc5koUqKXOK2WrfXNxfs
 JbCK0QohYYMM1M366+XfpcCRy1QytabcXAgJo0Ze8cB4jVUlKD65lfI8WQBga/m9vsOy
 mUcRw7uO8vRwO4i2C0iP/6j2c3M+aLG0b5ln9D09PHXQdM3H3/YL+nd4b4RpjZXvCwfV
 4+tIWsSqiBXf/wYMZkyABabtXo/O9ii9ioU+ExxD8/9oGkto+xL8ZegtkrTGhjd+ADs5
 W86jL5WAeecaGBlRwKkgkTqvXfASunrnHqJrCt29TEeBgNQBiNL9H3c9HpW5xIIsGDEx
 VUuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788988375; x=1789593175; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TmRBrvRGbXXSbq+Xs00GvvTCj8zMY0dPwyym6mxQ0ew=;
 b=B7Gzmqw1wAHe2JNEZI12jNsH8sAIlrK0jOCuhgC+qQAp5WlBax1KG5QF7jdmPns+BR
 KeuPuvlJjxA6kuG6wBqWXRLdwosRPsf4lWxNUj7nbLlMJmXx3yxabBkX5zczQalkF6EH
 g0Rf0HFQxZiqttYFPFTXhlZ7DK4GhlN+3v5iZGPiMwH66BwC+KuNcYWhtZ3gYK60siWz
 RAP+U4GZAHac7/ybzFZR0C/4p52iG8GTWwRW1iNP2mROjh9YgJ4l/2Hjo4yaIuCDXffU
 poRUDEaAB35hxUVQWbuJFcGKe2jCaHtPeiEh0FhEl/RsbpsW+S/0KvHXSkXJaJZ1SKLd
 mBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788988375; x=1789593175;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TmRBrvRGbXXSbq+Xs00GvvTCj8zMY0dPwyym6mxQ0ew=;
 b=BAN6FaUpp8KVw5Hq5hgCfuLJjRmhZYg6Y151ZqEURNqwu1yL7s+wlAVg2gM7cNmCtT
 6mxBwJfDAKMn4rcavQp62ThXdSKcPKHej5cjqi+biKHjgvUNlC60/uUHUndwgHd1oBHr
 TK8xd68cURaiGf9gYm+/NFXwZ7kxpEzJArxtlFP1aHGZHd6se49od0qrQTUbA6/sgwWA
 SYO8cgOJm5ie1N2B32/dBOLQnRFdfOEzzNy+YxLHQsmBPwgjTBWuTZbCv+3aVnkCy0Mu
 /EsjBHgBmVnr2Oc9+4Sbr3aECL/51OpZSmgKv395pZA5qjC4pa8pP/0Nx4KpRJYBdlmp
 yAbA==
X-Gm-Message-State: AFuF++mEpYcqIWYHLHuhr3FK4xj4e2zrNjpCFMkce6f/sEWVb/w+3Tc2
 LfqlX9Qlfufq/gepp/QIshmbBLxF3eAt7u/XkN+bFK3ovEOmI+zbsQ671Nu+xthKMzgByMNifFv
 RNWbbZbo8+rwzwdJAr3rvWQkm3innUxVnH99r7SeQhaPVix8STjKvXJb28kX+U3VBs5gOFXQzEq
 4hVqtFM++lBNmAAgDda4lPWNXUxtvy5vd+
X-Gm-Gg: AYBFou3dOmSnhmFoYFnBSOSbQPTLWvOSwozu/VSnJWeOmbeZh7UH+CsAhaOjEBMMnV6
 KLCredKsRT5SU+FYf2OijAeLBWPxtpQqLEImhLCzfEftp359u3Yfju8bWFoREqCnUrKkD9qU/jf
 CsG6enGigDIZl5Wx89MH32nvs/4JM+fmAjZo1ZPur3yXLpFkWuKq4OR/XnNA==
X-Received: by 2002:a05:6820:6ac3:b0:6b0:4170:59ad with SMTP id
 006d021491bc7-6b6fc7d1f64mr23916026eaf.24.1788988375167; 
 Wed, 09 Sep 2026 14:12:55 -0700 (PDT)
X-Received: by 2002:a05:6820:6ac3:b0:6b0:4170:59ad with SMTP id
 006d021491bc7-6b6fc7d1f64mr23916003eaf.24.1788988374713; Wed, 09 Sep 2026
 14:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
 <20260909040137.3414132-10-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260909040137.3414132-10-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 16:12:43 -0500
X-Gm-Features: AcwNN1WQBxzD2dhteX7u43KZi8ggpruAU63DgIERoxhO6oH_sfX9s-Yq4Udxv3A
Message-ID: <CAJ+KCYPE4C-9J6nd-fTHpMTLs12gOmqCGFzeF_uzj2gyo9yREQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] tests/functional: cover v81 system registers
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=IfsSymqa c=1 sm=1 tr=0 ts=6aa1cbd8 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-GUID: 9ya3IeT7o8PfyGSihtkKfQRDSOtb6OWD
X-Proofpoint-ORIG-GUID: 9ya3IeT7o8PfyGSihtkKfQRDSOtb6OWD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIzOCBTYWx0ZWRfX1f1ZBmGjmQSG
 efuNoryPnzqDOZ9Q97bf2DMt8bRb4kHM1w7WIMqBerA6T729uFP7hgz82pYHFgGVvZJHNu3cgLQ
 Pm43GDzzQ8YG+7l/JgY0w7mNF8cavsM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIzOCBTYWx0ZWRfX7z3L2W+Tbq/s
 Cy5sDK2f3SzZ5gYvwUCk8LECQ5Ea0II1/cYtDUlpnXZa2Kp4X45ma16Yq69DkKUfMO23NofXBlL
 4/NYBZiwEgAwtHlMrrYkLX+Q9B99WK2I1nqB4alzqj19MBIHAff9QCfWJcxSfNfApOzN4bobZzQ
 2xHxc3FiM8bwV6Mh9es5AtPvdGnuIeJRmaSI7H6SaCAjfHpelADyOduhvX/t4jeWfxJ00Pyya/5
 jRxdFlo+KRLT8KXXLWUO2hHGxACslePi8vpTCuWDhWiASHWwwtkPG0ed1j5yj0PtqfsfK5A8jMR
 krNzomAbK64Ni7uQzZ3PU+DCmz8+RIrltji1efpW0BwXh5ZuT41gsm+UoBrY7yaBJLMjLiGd5qd
 JzSZ9vs2+VrqCEBFMO6qj3nUIeaBsNEMGJVsjG1j4lCp3p7/q1NdPh5mX1gqk4bW6/b1kFzyYcc
 Lcho9dKao6iF8exOlbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609090238
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Tue, Sep 8, 2026 at 11:01=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/test_arch_tests.py | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

