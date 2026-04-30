Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1353FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIIuF-0006ro-5h; Thu, 30 Apr 2026 00:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIIuC-0006rH-Cj
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:21:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIIu9-0001z8-L3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:21:39 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbWZv3665186
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DnKoEFPQZ6OskxoPiKMroBKa//GB6YMiRwOvIycIbvg=; b=JkEeYk8V55CDM8cq
 ZomNpNfeMBcDWMMw4SLTKP7DhgT/PUgqz4UCWf5ntZ7ZUmICRFyf2fxsvbQwJi0I
 JAQHRQwZby/KNitmrtFsShTDJtmhtFq/XiekgdJbXsil4mwRzg0iutunt3RUsKV9
 DnxQ6BUZglDNrlnlI6SKRlamiEt3z2r8mJY6ABT/24P30OSyZOScP+3ZfK5UztiM
 XvSwW/8QwQYoIETixg3jh1ChdhqllR97jmRO0WkzuywYRvy1hwdNV28Kww9tuun9
 Hxrai6eMRpz7BQsEeNJ2JgJ4hBFqZvKCDKP3aCdUzIVi5PuC8rDQ+tJBSHXgIGCP
 FZ1yZw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3vd9a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:55:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so982258eec.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 20:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777521319; x=1778126119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DnKoEFPQZ6OskxoPiKMroBKa//GB6YMiRwOvIycIbvg=;
 b=TdDFXXMu3e/H2/V1ad/JGPEH93GxejEXsmngT1kM8M/f5npwl/nG9D76AiSV/yZnD6
 STowtI3Ryw6Ay3jSlbfoPQFu69Rd0pyyMUTGLxd03UgtfQFDnzoqpp6De6dXBczTngfR
 83rpKTrRzuinGfq+qpZabIdWqQtYfCBu66jnH4EtfvIuaFbv0npLrUN22sPrYzBhK0gw
 OTKT5b4jMyCGHgXaQhve8WqieScfs9UcVGc8We91y2S/bd+JuieNQPFYTB6XcaIblhOu
 /6gPTFEv4tpJPHS8ySddMOw3YKCboAlBq5RmVVMkAOT2E/HKmWWiYBA4mkmMy1Udwuk3
 pZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777521319; x=1778126119;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnKoEFPQZ6OskxoPiKMroBKa//GB6YMiRwOvIycIbvg=;
 b=ffW/c+4XRaGdLmQNhxumpEEKwJ+ju1nv3d0bqMbDoggUiT0T4GQKpm2pL8tT5Rocm8
 aKWYrhRsMGuryPUoF0cDWjjSngdQV9D+MvVL7rlbV6yIE7sprQCswzR+rj5W5fM4vMqY
 Gfi4G60cV5b2+2Zyu/Klc7fjH6j+Kdr3fkPGtCdZQGVKGW/FTfBzRLPq6BTu8XqtiIi3
 09wOt5bHeLsFuZFlNFXJiuUMj3QJkZ0FZPgJEWaokQzRR5aMwj51XooSl/Fd0ZvDmX/z
 H2m3opr0wvtLpSJ5YLKBnuG+P05HN4o+WnLz0SNSM9Q2hCPj3/wcEGdra0BarRevun6Z
 mMpw==
X-Gm-Message-State: AOJu0YyusWKEirSKzk1h19VcIZBYaQxu3rofvK8NfeGR0OxGUD9oRQKn
 aNka+Qo5HhQhnaVBDDF4PNj4GWodzx4cL1f9Nt0S9dkcsua4+slbuwrHtBVlvR2d+XVR8FKmKIV
 AXgEWf+9HThcx7+EFOf7HvTs2QYmVrCZeyMns6LHl+PVyhannBIs8UU9cxw==
X-Gm-Gg: AeBDietaR9pas8Q/ECDIfVllCQ97ypZNLb6/gCjkKs7Ol+bBfeMbIRk88AHER63Vpbz
 OT/4Dz9jz9N3GXUyeVrlyAq+VEsZ8mHL7w3mf1YRCBSMHVUfa0WUg76kXkTz8KsWDuA0LTd4gXd
 chh0F6QKVVgKICA6O0gIo0Fguux9AJuqOadzp7cSB7DKegRQ5UrnB/7GWst+1Vz9drYkl6u1N3H
 PF55IjjQcdksrGKEGkXfLzVE8Sj6/sfAcpaQdz/dEOqQqEs9b80e1dOH/83YUxkDUnpFIpJ1GPg
 S0SzEq22AWormkAw4HYKB8Kn4UL0Ck63PFQvHQvmqW9nhgd4cnuxX4szdDgw8rBL7DPefRgZCoi
 kT2z2IgluSPRO2L27FycPEpKPxGrujA1n9TBko28vwy0HZVQGr8xzE4Xt1BFO8Y61peLapYBo7F
 wyZrAT+6lbxgaJD42pVWqIsxmD
X-Received: by 2002:a05:7300:6d23:b0:2ed:e14:7f55 with SMTP id
 5a478bee46e88-2ed3ef6df48mr402469eec.31.1777521319484; 
 Wed, 29 Apr 2026 20:55:19 -0700 (PDT)
X-Received: by 2002:a05:7300:6d23:b0:2ed:e14:7f55 with SMTP id
 5a478bee46e88-2ed3ef6df48mr402461eec.31.1777521318844; 
 Wed, 29 Apr 2026 20:55:18 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c0991d0sm4946897eec.20.2026.04.29.20.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 20:55:18 -0700 (PDT)
Message-ID: <87d09279-c13b-4197-a347-26d484645f4c@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 20:55:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] bsd-user: upstream ioctl
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>, Alexander Kabaev <kan@freebsd.org>,
 Sean Bruno <sbruno@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <31f894ed-4acf-4d0b-9335-c94d67dc53bd@oss.qualcomm.com>
 <CANCZdfqBzFG4=h6GXd-a_g_xZW0LgRAf_j9CBn7HWScxfeKDAw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CANCZdfqBzFG4=h6GXd-a_g_xZW0LgRAf_j9CBn7HWScxfeKDAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hwVaMwrVcJhZsyfdYU1U6FByQh8ex7Qz
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f2d2a8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=UDFYyeKIAAAA:8 a=7Qk2ozbKAAAA:8 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=8Q1BNu2pXQZjFYCWO-kA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=ItlKd2BftxWApCZtRiMt:22
 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: hwVaMwrVcJhZsyfdYU1U6FByQh8ex7Qz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzNSBTYWx0ZWRfXyXNFjaDLlG2R
 Ea79RZn1JsvhJI24pXd76gDj4zHXk6piWyYz31cBUrmj4DYrnopWXSYnCiVUbHIrK+QlEg/Noma
 VntYZHBlgg1QicbvJdGHrVTedlVNc+sksigpcNciLmHTPfGc0RM0uDY0kzXhEWL9XzDR209GIm7
 cyEPJExLgg4c/rPwzLqqAqiU1ryaege/LGoEoXbeWDVt/D+D2lmG1WvWWt/XC+AxPzFpgwqfDT3
 LjFGrdQoi/3fsmY1/KpyhS6Noq49Y31d4PcPTxeD8Acxd14XkBMn1QJZu7ct2qlG4oGOrLrOoE4
 LL83bv3qgRBQdRFEdpmoYS3IXkYHBWkJhPN+3C+0q8kAkKinkVnZKfrkHdG9xQps87McmZgiRN2
 LmEgMfW18yXvGenXQQoMyPCP09XQXGsX+e9RZoaYMUK6j0mP81Sg2JFDLQ/htkER+S4zo5FTZlO
 yT4+v0Si71T1E6+KJ8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300035
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 4/29/2026 7:14 PM, Warner Losh wrote:
> 
> 
> On Wed, Apr 29, 2026 at 4:52 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
> 
>     On 4/29/2026 7:45 AM, Warner Losh wrote:
>     > Again with the help of claude, harvest the ioctl changes from
>     > bsd-user blitz branch. These are a bit messy, since ioctls tend
>     > to be a bit messy. Ideally, all this would be generated, but
>     > that code isn't ready yet, so we go with what we have.
>     >
>     > Please note: All style complaints are false positives. The > 80
>     > character ones are fine: these files are semi-generated from upstream
>     > and fixing them makes syncing harder. Harder syncing in code that's
>     > basically boilerplate is worse than lines that are too long for
>     > definitions people are never going to read.
>     >
>     > The two errors:
>     > ● b64902a56387: bsd-user: Add bsd-ioctl.c infrastructure and
>     termios conversion
>     >   ● checkpatch.pl <http://checkpatch.pl>: 197: ERROR: Macros with
>     complex values should be enclosed in parenthesis
>     >   ● checkpatch.pl <http://checkpatch.pl>: 198: ERROR: Macros with
>     complex values should be enclosed in parenthesis
>     > are impossible to fix: they are what they need to be for the macro
>     > tricks that are being used. One cannot add parenthesis and have
>     correct
>     > code.
>     >
>     > This is largerly unchanged from v1, which didn't get any reviews.
>     >
>     > Signed-off-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>
>     > ---
>     > Changes in v2:
>     > - rebase forward, minor tweaks for blitz branch evolution
>     > - Link to v1: https://lore.kernel.org/qemu-devel/20260412-ioctl-
>     v1-0-1d998a460560@bsdimp.com <https://lore.kernel.org/qemu-
>     devel/20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
>     >
>     > ---
>     > Stacey D. Son (10):
>     >       bsd-user: Add FreeBSD tty ioctl definitions
>     >       bsd-user: Add FreeBSD file I/O ioctl definitions
>     >       bsd-user: Add FreeBSD socket ioctl definitions
>     >       bsd-user: Add FreeBSD cryptodev ioctl definitions
>     >       bsd-user: Add FreeBSD disk ioctl definitions
>     >       bsd-user: Add FreeBSD IPv6 ioctl definitions
>     >       bsd-user: Add FreeBSD ioctl type definitions
>     >       bsd-user: Add FreeBSD ioctl command table
>     >       bsd-user: Add bsd-ioctl.h header
>     >       bsd-user: Add target_sockaddr and safe_ioctl to syscall_defs.h
>     >
>     > Warner Losh (7):
>     >       bsd-user: Add bsd-ioctl.c infrastructure and termios conversion
>     >       bsd-user: Add log_unsupported_ioctl function
>     >       bsd-user: Add do_ioctl_unsupported function
>     >       bsd-user: Add target_to_host_sockaddr_in6 function
>     >       bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int function
>     >       bsd-user: Add do_bsd_ioctl main function
>     >       bsd-user: Add init_bsd_ioctl function
>     >
>     >  bsd-user/bsd-ioctl.c                  | 438 +++++++++++++++++++++
>     +++++++++++++
>     >  bsd-user/bsd-ioctl.h                  |  14 ++
>     >  bsd-user/freebsd/os-ioctl-cmds.h      | 151 ++++++++++++
>     >  bsd-user/freebsd/os-ioctl-cryptodev.h |  74 ++++++
>     >  bsd-user/freebsd/os-ioctl-disk.h      |  41 ++++
>     >  bsd-user/freebsd/os-ioctl-filio.h     |  34 +++
>     >  bsd-user/freebsd/os-ioctl-in6_var.h   | 217 +++++++++++++++++
>     >  bsd-user/freebsd/os-ioctl-sockio.h    | 240 +++++++++++++++++++
>     >  bsd-user/freebsd/os-ioctl-ttycom.h    | 237 ++++++++++++++++++
>     >  bsd-user/freebsd/os-ioctl-types.h     | 104 ++++++++
>     >  bsd-user/syscall_defs.h               |  10 +
>     >  11 files changed, 1560 insertions(+)
>     > ---
>     > base-commit: becd22fdc2a071783d9e04421526633772b3b98c
>     > change-id: 20260411-ioctl-68c80a77ad32
>     > prerequisite-change-id: 20260312-share-thunk-ab1585477999:v2
>     > prerequisite-patch-id: a048e442d9dda7ee4ed1070ef5eb524e078b9a3b
>     >
>     > Best regards,
> 
>     Hi Warner,
> 
>     a few checkpatch warnings:
>     https://github.com/p-b-o/qemu-ci/actions/runs/25116258138/
>     job/73604077805 <https://github.com/p-b-o/qemu-ci/actions/
>     runs/25116258138/job/73604077805>
> 
> 
> There's two sets of warnings. The thunk.c warnings are irrelevant:
> thunk.c is
> a verbaitm copy of linux-user/thunk.c since that was how I was told to
> share it.
> It shows up in the CI as the first commit, but it's an already reviewed
> patch. Those
> won't be fixed because it's inefficnet to reformat code I'm verbatim
> copying.
> The inclusion of this patch is the series is an artifact of b4 and
> having this
> series be based on that prior series I've not put into a pull request yet.
> 
> The other warnings are documented in this message and are false positives.
> The macros can't be written in any way other than how they are written.
>

Yep, I noted that.
And saw *after* that first commit was not from this series.

> Warner
>  
> 
> 
>     Regards,
>     Pierrick
> 


