Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C287C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiGwX-00011i-UI; Fri, 10 Jul 2026 15:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiGwW-00011U-1N
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:31:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiGwU-0006tf-1z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:31:23 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AH49ep1326574
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 19:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kkkjsf3TTPTIypaR6sBiShQRfjxAoYVsMO7Dve83JtQ=; b=opjBqTu/kqDQqWgX
 dhepDeAV0jwV30eF6CgQS26dRNOsY3crlCNt7m/Ps3affwQOGMahw8/O1d35t5a2
 QcRogzaPpjy0h/Cd8RUJj2lrc16mDwBVcJdENqRn+nN8k8unDJ4hC1EA3OkFFm5z
 IWhHiuZ5KfrbFrAgWheL7X0JN+G/JbpzCHkBz9DHal8Yizph8fqj5Q05kPVwcDxj
 jCKLCI4LuiZWSWs52A91FeV0UIE9CVkiIFkp1gNM+vfk/T/rXeWaYFvBBjctid87
 aEWCzJ/FSYRmL5lr5rgzfr4SXR8k+0jIg4QwE2dq+ew9y51POTs3i/SHSqK0tL/0
 zIyGbA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb339rwur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 19:31:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so2306066a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 12:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783711879; x=1784316679; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kkkjsf3TTPTIypaR6sBiShQRfjxAoYVsMO7Dve83JtQ=;
 b=dca8Uc+E5dC/rebneOQG1P4K31P4B9Ul9czmK39u6QH3+QrWprn1wHltV2PEgng0oW
 uAuIr5Jftd2jf8lVgkvdvXvCCCO3JHJD4osR74dvqrIIIRwf6a23h8u23QVFKF+dp81d
 ItxyHsUc/P9S0yf80kue2hjmj+fxxLCzpnAFc2H2teMeYHpOaKVFRKxXcKdpZ5aP+4NJ
 NNC0gUaLc/PQOUIykdUjXlmHHq1Y38+vorvCd2oSF3gRtw7sMFgkeCfSCDr4/A9rMBFB
 dRwbeYP/Mcy3JUtmY0kvyoTeT3vcFOokcPDPxW92Mw2R33IwWEnNoJW2v6NLvsoygs7Z
 BSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783711879; x=1784316679;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kkkjsf3TTPTIypaR6sBiShQRfjxAoYVsMO7Dve83JtQ=;
 b=HjtnpRktcxoc8dkY1YpgZN92sZQmjV2WI1mdMdq8Nupb8BYa25g7lMsfQnfp+oDexY
 54ImNLqxNBqnK/1tii6+RjnGHICn1F5WTwft2I+/BuQ9H8eYGRlpt9wYXogtvdw0O8L6
 1sgfpHd/hV/Tl0Elu9uHtzDUfNV851vbFsiJhjzojAHQ4Uve+UOuQ3xX3B8sW97KANIw
 c0aiGUUyILUhnbMBtnkojNjH3CWHo+vjdTWcYjs2mp2NZqH03VJq+bvus6ax46Sl5hki
 i4fbyG27m6T8gnpi5HeqgHfAcQi7a2JzOz90si0SFEnoBaq4RgA+/g8XpcZw5yA3KhBF
 LPCQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoI72gXULrDTbUmz0DI8YJmy+rnN7tPeTgM6yjbA9cMtzejafYrHNsZrP69Cy4hkJ3twIOA0Q6e3sWD@nongnu.org
X-Gm-Message-State: AOJu0Yyf1ogghsM3W84z4zBpsJdxuVdHUieontcpRnLK8yFhQ+/Ieng2
 XyWxx2ZKbpnbUZ4xauexkRb7EJglRQoVvkZ1Ph959sAMDdHlYpg39lsjuXmf9RCoN30OK1d0mzu
 lCM23K2zN9uuCZLjh19r6FisQ3nwJxJ/TM7cBACcOopTbMk7geck58gWLNQ==
X-Gm-Gg: AfdE7cm+yxbkKCQXDIu8Y6HljkxWd7kM0eq3sIaGIGNKWOT54DSTKXv6TPXfuHge5VF
 2OiXfbW2n6NGV2FSNsqNMl1qxlF4oJzFxwfvtNgMrrN42nj2/U6nk2ZTiLX3Dv924jC4eC9hbQe
 EGQ16JfNiDXa+A/QVW92bmB4HZj2c3XH95IYFNhqzPLp88TFLiPyGBlhYKu0X/9js1vh1dN3jQO
 +7sdEBhcxYknzjWKy4DlNMPVPee1qsqaBG9UP9++DMi0TmGVNp3+jE0K3n3nZtxS6ZLTgzRACQw
 UOfxlBeszxXILsbK6SOHGIlcCrASTL7/XFaonNbObJYUVLeo5kEblOWbelqMJQiiSku+ozwM4q6
 XYk5ss8ULobXqw3PfesL7r99Xisnjo6oMIVvAGlQ7qxxL++B8v9nGQCT7onbRJcG+KXHiJRbyrw
 G3Nt4=
X-Received: by 2002:a17:90b:57ec:b0:387:d9cc:7dc2 with SMTP id
 98e67ed59e1d1-38d16085723mr6313656a91.20.1783711879288; 
 Fri, 10 Jul 2026 12:31:19 -0700 (PDT)
X-Received: by 2002:a17:90b:57ec:b0:387:d9cc:7dc2 with SMTP id
 98e67ed59e1d1-38d16085723mr6313607a91.20.1783711878784; 
 Fri, 10 Jul 2026 12:31:18 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39149591eec.21.2026.07.10.12.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 12:31:18 -0700 (PDT)
Message-ID: <219adc34-b400-4f09-bfb7-0448b72494e3@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 12:31:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] meson.build: re-add explicit gcrypt/nettle request
 check
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>
References: <20260710132531.97844-1-luc.michel@amd.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260710132531.97844-1-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE5NSBTYWx0ZWRfX0POn2H4vNRj6
 J5hBLlw9LVDe4hR/JFNBAoCuB0JxvZfh3WFMsmL382FLDVjFscBG3UrSsgLIcDMa0WKlvI890BR
 xw3EHJETqJey7M9GIVUjwFhW8TJs6F8=
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a514888 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8 a=0WD92GgiYE6-ty2h90AA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=0lgtpPvCYYIA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: pelBoxYIlB6UrfMNJEROMOOSCD7UojIH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE5NSBTYWx0ZWRfX9NsggClvuXZP
 NeZJoaIRn5GwHsEgUFSwDoX9yMqGT6pjtoJd3YkT+WBLZiGzDp7Fi0h56DGBFB+kWlbwl2RFYxS
 PZNMTrmCyb9Cu1auKI1jTv68YDUlPqTqyshHyAKxseWiTK6viyWELDwfH76pZcaQ7wJYq4tSq57
 88okY3qvAn0aUKO3NciqcGASWIwwj+8/m/Lwzbq62D1LDENh0M+Vxx6uhm1hn7gnwnVpa1/akQh
 n0DtVZF8zxkdp7hS8gEkzP15H7LQ5EC+6qwISrVu00jZnfkMboyvBrDd6GltXuc/aLpX9xwRiN2
 LvA4iEflkkr1wyrZIHpGbd8RY0yXbLIKUAooJZy/4ryp4eKMJwb8ys1NaSghYOifKPdOS1BZDZ6
 vKKOktl/PrvYna41E/PDP5f0pTuvGiIoh3sjHyp6MZw4cf6neY5ifnE4rts3fk8wykG3ChOohOF
 1/sW0zMH34NXUihx0tw==
X-Proofpoint-GUID: pelBoxYIlB6UrfMNJEROMOOSCD7UojIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100195
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

On 7/10/2026 6:25 AM, Luc Michel wrote:
> c4b3d0074 removed the check that nettle or gcrypt were explicitly
> requested as the crypto library to use, breaking the --enable-nettle and
> --enable-gcrypt options. Re-add the logic to force usage of nettle or
> gcrypt for crypto operations, while still keeping gnutls for TLS.
> 
> Fixes: c4b3d0074 (crypto: bump min gnutls to 3.7.5)
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
> v2:
>    - Revert more of c4b3d0074 to restore the gnutls_crypto logic to
>      disable gnutls only for crypto ops but keep it for TLS [Daniel]
> ---
>  meson.build                    | 11 ++++++++++-
>  crypto/cipher.c                |  2 +-
>  tests/unit/test-crypto-block.c |  3 ++-
>  crypto/meson.build             |  2 +-
>  4 files changed, 14 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

