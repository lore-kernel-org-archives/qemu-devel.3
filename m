Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E1D606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YJLs+pB0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TmbeDM6W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgNT-00029I-8i; Wed, 04 Nov 2026 14:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xOgNJ-00025h-73
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:10:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xOgNF-0007rT-Pt
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:10:20 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fj8E81692569
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 19:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0Fy7b1GMNREHKvhrpuM+wIjntXKMEmwyWEqRI/6PSlk=; b=YJLs+pB0q3eImyP3
 Jbkf7YLzrbkXU3aK8qvqcHOeoyAtQ3IYIucLuY+j5XjBRdviztkdATBSlNl5js4I
 IBEvdPLsw9oLIQ62QQC9inctEuRGHFI8fr6jH1PywZJ+gDygxs6dD6fP+mTZjP6/
 hoBJxPBJUUazEOBMG10JTxG2w3KlC3zawLLCIPKMdFWict03TwJdgNVhYgDNCK35
 CndwX+LSIEaYKmxfK8rXvxpGR/CobQKvdcGsM7mMVz7mfKVxE90owyJvQ0SjulKY
 PJnlMrUooJj05XKDZ2gavRMmnRJuTAZNNgkAWvK3Gs4GKy9iT2lbDWkKaoQavzPJ
 ZWMciQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6br17xb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 19:10:12 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4ab4f652f9bso849022b6e.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:10:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793819412; cv=none;
 d=google.com; s=arc-20260327;
 b=KcABMFvZ6hHqz41m78aDZnBxQ0CXPqUZwiac/Zvhzajuxln0x0dQ+WnpKbZMCu8yjW
 WCdctr+9gpNV5lQq1K2QZeTTWJHRseuirqPHHb6TX+15WZXIzjoVHcbFbWlUMumMCy+M
 +xz8MRu9VQEOcEooveYVqhPpL2XdcL9gwzfMgT97d9YxnyC9jtjKTuSKQMmq8KUQOWLu
 D24lLUJg5Zz7/9SzjDGuL3v8mNKf7TBfWiW+tocwW21pHajrfi7QhW0x4py0w0fXA5/S
 RHUH9DC/ShvFsRaWD6pndoVLXdYBvabsKknnnSf5Sd1WabtSBFIRSph9eyt/2PmAq1Lx
 rPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0Fy7b1GMNREHKvhrpuM+wIjntXKMEmwyWEqRI/6PSlk=;
 fh=0jxw0kyDANBD2DrI7tYX7J2C2ltCf3e0+4mx0fqMhxA=;
 b=jOBQeKCusK+h3n4WKKh394eQZSoG1HzdnI67/SGfXNDhq4GqGqk9jXki6ZsOFW7gt2
 htTAEGr8DppMuWLWn9cr2Wpl9jxMFe5oKivX+orDEjDHliQ60qyqOe7jTHRPwVWkXGBN
 8LLoAjEvBbEYz3UkjAtKU9jxSUGlYkFoWSSEAs+ZdRxQy0yuq84c3q8Lo2IM8wr1d83w
 8gkjUMDHdIw21/Lul/GRSaUDStkaYVn29wtfJhy6N4+lXrXln5OTIoxva55ggfokcZ8s
 IvGtxLuUTGG81WQM5e0KZ4pOn9dzPHjZNwStJfFRhPEkDAXzYoYsDm30/4yZGVeEsyDj
 mN5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793819412; x=1794424212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0Fy7b1GMNREHKvhrpuM+wIjntXKMEmwyWEqRI/6PSlk=;
 b=TmbeDM6WUdNhQo6apQjuj87hJQqCUcv1KAu30/qvp8Yr1vcwejrrrB9rCgMA4Alsdy
 0WMausnKJPe2VIOY+rPoY0C012htReJLu1N9Oavj828m/M+JbdQgRf8qqvXUyoeD99nX
 AOxuoQm6StdTUJ2rQGn/MQeBH1tz8vG//bi8bIjCi1J/X3swafdEwZ1DQ0yyKvCiUSpX
 LuC0aZA9ZQZC+nA5HzzmiuSu8QJtFhZaGlW2aJ+ewnvvL3nCi2DPsnYIkSuwWPIMyElj
 nL5lY1Fs8MRaql+Z2+7I9jtK8ZjcOL0H2Vbetoj3j9PddQciWpXywf0+faHJF4n0UFVc
 xWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793819412; x=1794424212;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Fy7b1GMNREHKvhrpuM+wIjntXKMEmwyWEqRI/6PSlk=;
 b=scZl94WABumBCS3++eI4H9zSxjxcaEBKw45fycihA57OuGWs7eMqEOEaEnL4gd7NIO
 RsgxoGEtorRXrBjZ1X/nJn2q0F/n+RaKvciaf+eJMoZq3VeKPVZne5D3ppC63L4X+8Od
 DYsGpyYZ8SR269KBnHzFYiDqvgLMLJIg9iR3nBszkY/pwKcsOSZcEMlkSDau96hVGjub
 Elcx2tugjeTaIy5BqO4orNcAPpPttpRsy263D/yzn2UzjFU3+GvO07TsnLC5dtQy1Y5W
 Y1uWOjflXUKhZKPxazj5ZH/1gqt9QxRUweyN0L2PvhwnjXicGkFaUflG6M8SfHj0K+Rv
 DEQQ==
X-Gm-Message-State: APuU4Z8AbVN6UWezXoIn0hDbI2Yh9OyGj8KAGrLyOEqqtD5bYN8Lth9/
 QGW8brbtQh0kawr6PbAzguUuU2tzdOyLmwtSEp4Q1ICw8YVYnIYlc7O2dxOgv9TtkrRp/P092Mc
 9tfZ7oPvKhoJBGsan8eIqpEUK2WrW0Yqnjgm7Q5GzgHq5C/L0ryO0BXzQDjbjuUeZEbKqfiB/2q
 avsA5FUWLoAyAghKQYAvruJ3R9xf2XQX7b
X-Gm-Gg: AYBFou22h/es7/hL5qlKq5sTAU2USLvfySXHyne9y7C3AfaFvh6qT3GmHAEr9//PFLl
 z8JKnaxxP+O1mXTJu2weHaptBSVEVzQ0HZa/vqrXVwdL9hZlzmHWJByq3MToy5tnKuQV033k67d
 AMZU54lSecmjO9szVjMcJ+6xo/K1iuZYEfP5gKhLt5WWOEhradszJzcxiGpl9Gs445PxG5Vol4i
 gFhspooo4NxPQJGJw==
X-Received: by 2002:a05:6808:14d3:b0:4a4:744:a4ff with SMTP id
 5614622812f47-5640d94a060mr10893809b6e.4.1793819411837; 
 Wed, 04 Nov 2026 11:10:11 -0800 (PST)
X-Received: by 2002:a05:6808:14d3:b0:4a4:744:a4ff with SMTP id
 5614622812f47-5640d94a060mr10893780b6e.4.1793819411216; Wed, 04 Nov 2026
 11:10:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030222146.558366-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261030222146.558366-1-pierrick.bouvier@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 13:09:59 -0600
X-Gm-Features: AclHuK-9bUfuZp9RkF4oZiaL94i-NXdv12dudaX9puN0kaJIvorBxgyEwUWjHcQ
Message-ID: <CAJ+KCYNmsGqnF6_wYxukntNO00sALXwvFGhEKU4NVBh6EbM=SA@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: reset supported features on Supported request
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 brian.cain@oss.qualcomm.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 Justin Sapp <jsapp@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3NiBTYWx0ZWRfX1oq6/oCiJmeL
 VUoXwuNs3bY5Dy3a55doDDe9+U5+NCeYhp1Wp/HJjd7A2Xqmnk7abaVWuHmJk3Z3QQJoluAOXxs
 +vlwoJn1IVsblpu0sKnsZkpttBTinu0HE5aWqbo/ZNa8aMDmtMBrrnuGwA0SWHVTVLX6NC5bJw6
 PDQjPon8yhEvHxIrgGG6pCF2Z2DDcmJUiuLmeWzuOYxjiKpTSerS+95wCjlQoM1dGxKSN+J2FD/
 QoP7paHGACQ7CDkVlcosZym4TbwuAerjGARxpeWgLWZMo7bynpYzshEQYXnqIiEC896L5YYvtkR
 ZOHxF6R2gg/61Uj4I0ckllk/+q45XOCeKsv4glRfP9g8XqkOO69nLe+PeTIS2NtUxjh5aSrNY0j
 fUroPQsBznGUnvsGEd1oKi1/9EuzH/Yn6sv2FxNFm6oE+OFQ2PCvtO1K8u1r2BjMbzgmujYV4N7
 zk58S+WRCj+VHaYqxmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3NiBTYWx0ZWRfX1LeVRGlLdxMF
 EIUjsTD70gYlcapCH+U9ma/6xiZsP+tIVUOOyADBwfqRPoi8VD1AhqxwqncPnK2plflUqT3dQ1I
 ZPZ2DKUCjfkUrqDVj1P4T+Vf/kzae3w=
X-Proofpoint-GUID: tbNvgkXguaHjbMxEeN7gYLyeFqnyWZCH
X-Proofpoint-ORIG-GUID: tbNvgkXguaHjbMxEeN7gYLyeFqnyWZCH
X-Authority-Analysis: v=2.4 cv=futJ914f c=1 sm=1 tr=0 ts=6aeb8314 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=CCpqsmhAAAAA:8 a=EUspDBNiAAAA:8
 a=lDtavSEJtHVKaDUYZlkA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040076
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 5:21=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> From: Justin Sapp <jsapp@qti.qualcomm.com>
>
> https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Pack=
ets.html#qSupported
> ```
> Whenever the stub receives a =E2=80=98qSupported=E2=80=99 request, the su=
pplied set
> of GDB features should override any previous request. This allows GDB to
> put the stub in a known state, even if the stub had previously been
> communicating with a different version of GDB.
> ```
>
> We exposed this by connecting to gdbstub using a gdb client first, and
> then WinDbg (EXDI) for windows kernel debugging. Since they both
> differ in their multiprocess support, this was confusing EXDI.
>
> While we are here, fix the same for fork_events in user mode.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  gdbstub/gdbstub.c | 6 ++++++
>  gdbstub/user.c    | 1 +
>  2 files changed, 7 insertions(+)
>

IIUC, in user mode a bare qSupported doesn't clear fork_events,
so a previous client's fork-events+ stays active for the next client.

E.g. GDB connects with fork-events+ and disconnects, then a client
sends a bare qSupported. On fork() the stub stops the parent and
reports the fork to the client, but it should not report it and the
parent should keep running.

