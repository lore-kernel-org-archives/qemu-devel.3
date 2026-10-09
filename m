Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C06CA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFGOb-0002Ck-Md; Fri, 09 Oct 2026 15:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFGOa-0002CW-JS
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:36:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFGOY-0000Ib-Gg
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:36:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZarW3478360
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 19:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CzmrqTgAifCqNqqLKqk7aOjZ
 NBUfPOeXhWzi0tZ+2uc=; b=I0MRLTSctLSOByH5cEPAz/EuoELKGFBa/h+ktDlK
 VUeZFMexxaelH0NwtYex6IjqI+8uxvKDs0/k7GoUGzPiEVDhQQEk8TYJ0Kq/0AQM
 kLq/H/nz5kirpmh+4tPVNgGPA1rYlCQcEFagKH0E4UIWM+ZcpB83qJP3rJSbH0mw
 PeayBTTERlIviLW9RXch+jqSekEFkmg8bodTRgF1Zj5dIAc8MxKa8JP9N0iqOBfd
 4CIxu0YtPkpmSpmd8rCYj93k9gYzUTuPQI7sktoRvddgg9DM9W7tfNe0LnNrWeyG
 AOQdgnbAVC3vAfMbTD8dq9sH78eNsvOkgY4W9EEsCTyfdg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t80fcx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 19:36:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34ef0362d95so83434eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791574598; x=1792179398; darn=nongnu.org;
 h=in-reply-to:content-language:references:to:from:subject:user-agent
 :mime-version:date:message-id:content-type:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CzmrqTgAifCqNqqLKqk7aOjZNBUfPOeXhWzi0tZ+2uc=;
 b=VQiLXGLH6DeMzCZ9rs9gCtXwyF2WvJh+Bz6u+IaBGjua9lQZmUQQZLO5NQdFhz2Nqr
 nvvAmQW24stQONm2dpNuwwucvGYq65ZbD1GaLPJKbI2/kGWW/ga+wZNtV07m7PA/rocM
 G7LJSKgZe4tMrYI/7+cEPmidL1Mq49O0pS3vuKTkp3/lAL4gjSDafxTD8QxMQDs2Mvru
 tmxMF43lCDXl7Ty3b396afLWyqBhrtju2VWdDa1Dm4/NRSD+RRV0yuhagZD28jnUT3L7
 owAZxiDWAmIt+m70X9i/xV9lD+rA+9XWLTACC2aIbVqN/n9/CbkiWgvLHuXtaUgxjUrI
 txSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791574598; x=1792179398;
 h=in-reply-to:content-language:references:to:from:subject:user-agent
 :mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CzmrqTgAifCqNqqLKqk7aOjZNBUfPOeXhWzi0tZ+2uc=;
 b=W5yNiaPw0tAoRWZgL8Ina6b//W/ngunzAXYtJY5YFGgUMiDLC3yqEZ3G+Zm5ZyK63f
 KXpJSdMxma+kaDNlFeUIvfyt1xHUyblgytFUz2N8RFwfEK8ICDguoT959B+Gl79JBRoO
 mxnZIKrHcuAAiFqFhoUlbe9k6Bn1j5rdGjduFs9s0Vdv/dmtgexVWSnx/9b4yUnonrDK
 jqiR+ooc6jbj5BqUa4lh5RZDwgfsMBURwAR5LbkmQQlOusO1AvRJuqweJTBpwW2D2dHD
 hcN744tlQDaAwgO1jz1v//7JH4xv6xKWbNaXY9vaAlRHIUB0lOZ4FU5mt9Gws6+iZFG9
 EhAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9P6/i8I43LkxhjeGj/EyVJKGfSCKaOAFhy7MgVMT20eF4AlLBTv8koyH2wmA3y6DM38K6AIAC7D5U@nongnu.org
X-Gm-Message-State: AFq9FYJ2+8BwigEy6qvVxxyaptkgoyZAsnIApOVIRrC/x/PWTNp0HVR5
 KzuOYgNgFvFRSL4I4nA+M2r2nVOu/EJtIB8y0JfbSQOHYmipo8bQSKnDpVYSo5w3j5fiu6Yq/kl
 hwRLNN5TTbfkDL67DY+cwxG7wv1+RUbNhd2LY2mYAxYP7aFon96h5iGDW+Q==
X-Gm-Gg: AYBFou05IkDmo8WlJSKOU+HSP4Ik3RgU+nBHt/UfWInZDfms1jDfPaEsMbbdXGwry9L
 LOYFKRuD8AysnY1dNTl7C1jma1FWeQOrXwme56L0dVJvOm7uSE4Fid7BUk4of+hIHZaG0VVNb1P
 qJOyhz02Zs+hjIiWD6bOi3nehihUlQtdtWBhWJjoV6TGCAy6gUwX5dQx1fwwmQuY1IvlnlCl689
 iqOG8MU0G+KpsHfDAYVjJNnyrYZ6n3y/S2hY3uvkICZSUxjUXG09vRMPyXzalpbCwhoNShIigsw
 H7ci829v6bIZFonVLt4Xdxu4lw+w4wi2KpqnYtReLc0DCTF0+gdQlGGDPUK1f7H721FWv+IK3Ua
 GYWiXcbB+Dq3+aJsdBh9KtyI3C3aSmSTyrVQbK9Sijpvw683CZu7lxitxF5v/EB58VGROyA==
X-Received: by 2002:a05:7301:162e:b0:353:5d6a:1f42 with SMTP id
 5a478bee46e88-3537df5a2bfmr3878622eec.8.1791574597670; 
 Fri, 09 Oct 2026 12:36:37 -0700 (PDT)
X-Received: by 2002:a05:7301:162e:b0:353:5d6a:1f42 with SMTP id
 5a478bee46e88-3537df5a2bfmr3878569eec.8.1791574596835; 
 Fri, 09 Oct 2026 12:36:36 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb6a2afsm8809257eec.31.2026.10.09.12.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 12:36:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------jEito2kjR2zSvPjNGFsvtow1"
Message-ID: <24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 12:36:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] container images for migration-test
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, peterx@redhat.com, 
 mjt@tls.msk.ru
References: <8733vbtmge.fsf@suse.de>
 <bf76b7cc-9de7-4baa-9a56-d638c68a78a9@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <bf76b7cc-9de7-4baa-9a56-d638c68a78a9@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3OCBTYWx0ZWRfX3Y++l+osPutW
 nLACJFyRV0hWjq9qD/RJdhnY6MNy469ke8Q5UNzEXrngrMKGdIOySAMBcPQfH4Pw2m7QJkaDD9Y
 Baj1bRf9O0SoFWakEV8PplLuFxiktW0=
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ac94246 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=_qoOUMX07tc8rv5pwrUA:9 a=QEXdDO2ut3YA:10 a=7ufEvNj7VJpT7nyvF38A:9
 a=bhdUhfz1qc8A:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: ZtN0ilgPtgP8iCl_sJuySA6__UV8E2g4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3OCBTYWx0ZWRfXzDofocFhMoRu
 NvigQaIvP0hMBvpTjVE1btTACOiceOYexvUpEq2Lue7SnDI7POG8xE5v8KvXpUejrFGUcsNJVlB
 F7CK5mGDDCf2uZK+8XCJP8ELp8CQjkaE2xJR09F0qmwuzFd9bgrMYLwHPjLJB9vIjEeCKx3DCsl
 1i1MDAOD4EqKci/eL19tky8wKX7uuJE6gPFnol0N1UqrHUqdhzRszlz8Lg3zkT/Srx4d080WdT6
 /e4EZzngH1Z+68QHUDd3XIsq9YoqwlLjKUy47sL954WkiJVb+r5BJqJywu4l04hKwAwP2n2hxQF
 dEy3jUUi5yjivXw5xS7dneZMyf60/3HtjOjhVzLxTqq7Jkr0vqzYxQh4EumDqZXA7Jl7ndVdutt
 w/9D5etYLBBBTBZ/ePFLnH+0i367Z92niyFfkyCGgDcQT1xTiGqfga5pCpQ9SJ2wUMPHO7/x/j4
 SD9Dc7rpp16oNJQO/Dw==
X-Proofpoint-ORIG-GUID: ZtN0ilgPtgP8iCl_sJuySA6__UV8E2g4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090078
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

This is a multi-part message in MIME format.
--------------jEito2kjR2zSvPjNGFsvtow1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

See attached an example of a multi stage build that creates a container
having only qemu binaries, their libraries, and qemu roms, and nothing
else. It does not even have a shell.

build with:
$ podman build -f qemu.Dockerfile --build-arg QEMU_VERSION=v11.1.0 \
  -t test --squash-all

run with:
$ podman run -it --rm test qemu-system-aarch64 --version
QEMU emulator version 11.1.0 (v11.1.0)
Copyright (c) 2003-2026 Fabrice Bellard and the QEMU Project developers

Regards,
Pierrick
--------------jEito2kjR2zSvPjNGFsvtow1
Content-Type: text/plain; charset=UTF-8; name="qemu.Dockerfile"
Content-Disposition: attachment; filename="qemu.Dockerfile"
Content-Transfer-Encoding: base64

RlJPTSBkZWJpYW46MTMgYXMgYnVpbGQKClJVTiBhcHQgdXBkYXRlICYmIGFwdCBpbnN0YWxs
IC15IGdpdCBidWlsZC1lc3NlbnRpYWwKUlVOIHNlZCAtZSAncy9UeXBlczogZGViL1R5cGVz
OiBkZWIgZGViLXNyYy8nIC1pIC9ldGMvYXB0L3NvdXJjZXMubGlzdC5kL2RlYmlhbi5zb3Vy
Y2VzClJVTiBhcHQgdXBkYXRlICYmIGFwdCBidWlsZC1kZXAgLXkgLS1hcmNoLW9ubHkgcWVt
dQoKQVJHIFFFTVVfVkVSU0lPTgpSVU4gZWNobyAiUUVNVV9WRVJTSU9OPSR7UUVNVV9WRVJT
SU9OOj9RRU1VX1ZFUlNJT04gYnVpbGQgYXJnIG11c3QgYmUgc2V0fSIKUlVOIGNkIC90bXAg
JiYgXApnaXQgY2xvbmUgaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11IC0t
ZGVwdGggMSAtLXNpbmdsZS1icmFuY2ggLS1icmFuY2ggIiR7UUVNVV9WRVJTSU9OfSIgJiYg
XApjZCBxZW11ICYmIC4vY29uZmlndXJlIC0tcHJlZml4PS9vcHQvcWVtdSAmJiBcCm5pbmph
IC1DIGJ1aWxkIGluc3RhbGwgJiYgXApybSAtcmYgL3RtcC8qCgojIG5vdyByZXRyaWV2ZSBy
dW50aW1lIGRlcGVuZGVuY2llcyAobGlicyArIGxvYWRlcikKUlVOIGxkZCAvb3B0L3FlbXUv
YmluLyogfCBncmVwICc9PicgfCBzZWQgLWUgJ3MvLio9Pi8vJyAtZSAncy8oLiovLycgfCBz
b3J0IC11ID4gL29wdC9xZW11L2xpYnMubGlua3MKUlVOIGZpbmQgL2xpYi9sZC1saW51eCog
Pj4gL29wdC9xZW11L2xpYnMubGlua3MKUlVOIGNhdCAvb3B0L3FlbXUvbGlicy5saW5rcyB8
IHhhcmdzIC1uMSByZWFkbGluayAtZiA+IC9vcHQvcWVtdS9saWJzLnJlYWxwYXRoCiMgc3Rv
cmUgdGhlbSBpbiAvZGVwcwpSVU4gbWtkaXIgL2RlcHMgJiYgY3AgLS1wYXJlbnRzICQoY2F0
IC9vcHQvcWVtdS9saWJzLiopIC9kZXBzLwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMK
RlJPTSBzY3JhdGNoCiMgRlJPTSBkZWJpYW46MTMtc2xpbQojIGluIGNhc2UgeW91IHdhbnQg
YSBtb3JlIGNvbXBsZXRlIGNvbnRhaW5lciB3aXRoIGEgc2hlbGwKCiMgY29weSBxZW11IGFu
ZCBhbGwgYXNzb2NpYXRlZCBhcnRpZmFjdHMgKHJvbXMsIC4uLikKQ09QWSAtLWZyb209YnVp
bGQgL29wdC9xZW11IC91c3IKQ09QWSAtLWZyb209YnVpbGQgL2RlcHMgLwoKIyBidWlsZCB3
aXRoOgojIHBvZG1hbiBidWlsZCAtZiBxZW11LkRvY2tlcmZpbGUgLS1idWlsZC1hcmcgUUVN
VV9WRVJTSU9OPXYxMS4xLjAgLXQgdGVzdCAtLXNxdWFzaC1hbGwKIyBydW4gd2l0aDoKIyBw
b2RtYW4gcnVuIC1pdCAtLXJtIHRlc3QgcWVtdS1zeXN0ZW0tYWFyY2g2NCAtLXZlcnNpb24K


--------------jEito2kjR2zSvPjNGFsvtow1--

