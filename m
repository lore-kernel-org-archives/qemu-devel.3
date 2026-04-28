Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E4CFF886C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 23:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHrfo-0008NA-94; Tue, 28 Apr 2026 19:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHrff-0008Mu-UF
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:16:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHrfe-0002bq-1P
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:16:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SFsSIf1531392
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=LosJdDmqnUShnteklqteBC
 9T9UwIEdfmMrM0j3hSNtM=; b=loeMs8cBSv+a/0NUUe8ceQ80z0piWf1900EIqO
 za6SUmhkg/A00skHCkvyExnsWH78nNPONObIYo3KLm2cO5pIQnTbLrSfk8zuoJ5L
 dOvC5KNuWhH8cViWYLPM/2H1PMswi9qFJFlB/+OsiE9/FtlNZGKjC+WcB1MNf93u
 /kE3boiqcdulCEkkNmhZyrX/h6Vdp6NsxzqpOnj1KfBPShqc/tsSEkvI7cVXYwqa
 rhPnwAaWKzkF7b/+7PWO5+FWLO/vjwsQq0V1nWX+MVToZvjGJxiSwWG7fGmIUmf6
 Xg/YJ5mga3xArIkUP8z1ellPIivMyCggXTBPAZyVnIlA6TSg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtud22nx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:16:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2dd6fb4c867so25975602eec.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 16:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777418207; x=1778023007; darn=nongnu.org;
 h=content-transfer-encoding:subject:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LosJdDmqnUShnteklqteBC9T9UwIEdfmMrM0j3hSNtM=;
 b=gLXBUwubwLlmy6ZJ8YIpqUCuSycjXIaQvTtQeX2eHUYX//chncuWvArb5ErVOe1Az1
 hl7Le9bkRK4ood0cVzFYD85tp+qQmzZ9DvsY+I0Lx7QLR+zWQc7lq/V7dT8hP4P2H/HW
 8V+4cGbrFwTdR3Bf8iZ7SC1+aIw6XaSz/AIhOlV6lDBVUOH+aWhTXGrO7TDaKvsvKqvr
 5EWItNFJWune27B7eqhrtLKs4jB6xCCJEWsx79d6beBD1jrYDBkZ4jsHD20IdAEprGrJ
 xz93i0UyYIHw/4lPpaDkJgaRNAKUQ1YsjNRCpU1FkQlODbmCDb2Qdeh+GIrirb+/Ly9N
 KnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777418207; x=1778023007;
 h=content-transfer-encoding:subject:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LosJdDmqnUShnteklqteBC9T9UwIEdfmMrM0j3hSNtM=;
 b=FOu9Ba5ucNATohA4btKUxrboUhBcDryg3RiIX5+53Ab8xZTGh9bR9Ay03+c8EzFzz9
 FVdZltEP+3WVUXCgcJGq6geBX7XoNDoOrvw140cNLfR6x4MaP4kcQb6LP8GQ0RgK/Uar
 4Yz6H4n6f+Xja/ZMV8j3JKKu7mB7aZSDnKt1USkgcXqDQ9JaymKgVgM+ZyNJmbAs7+fh
 +121R/0AHBExfs0EMqPtx72BxeGviCAigT0mMruS0mFU06CX+o03LnPyPLxsmeYjkMIe
 /Ivji8XPIAxKO7XmbQ7gWo4dJs3FvcESY4LKdAWCreht/2yY17bkuoABJvqYhaqXJ9nU
 YxfQ==
X-Gm-Message-State: AOJu0YwV7QMRPlFEK3Fp9On6k0w0kJIyxUaneLEqKSveDYhdjtwRTTTp
 TOPPXYcyt1Lo0tzlmBD/XD0Yb/48mEJvht13rDUo6kpMBuPkRMJsnLy9nPWlWad5NIon3AqV5Fs
 CkQdHpY+2jiFx5ZFmyCMPZwzvlf2g19OQyhW0PgpyXdzAY6sRXerhUT+gj5HyfZ1u+w==
X-Gm-Gg: AeBDievCNpNLIx2t5Zt/EmrEBv0Oxg8OXLgPHWVPL8Prh36JwWAQhkIvcGVJnYc2rPE
 8hnKezDupPqWHD1MqEXthXRdeuSs48PPrquWkRmTBEp6VBrGNe/tkeyWx5Yujybl0M4hRQ1KhiS
 q+leiaxUT0cw2lEkfhnCGj4gyqo2aVXywWAv8sA0+tO7vXbIkBf+udUOWGbV9RV058TW+JDf5sn
 WneOhIKWIyWcS2I/40fjs8XAKEUbU0A1+ed4DjUpRUvQ+UV6r1nmx+NdWuKCyt0nTdCCyVJChnW
 g93mnt5UPeSA7wqU8bXkm3yXVGzeDT7kVMrvMyskQ7y7OZwQ+EWyuC19Ao+Mus2ifjhb0pdZ9sh
 KXJOi+Pu5tJiZFcnKWtXF9PCBx4nG4Y7dPhBUSzi9BZ0AojX8f1dSsW3s5HLd1NAy1yDjXdKPLv
 lELbF7UDNNpgBk6fWzsCIV0X3s
X-Received: by 2002:a05:7301:df48:b0:2ed:e17:d50e with SMTP id
 5a478bee46e88-2ed0e17d729mr1348215eec.33.1777418206855; 
 Tue, 28 Apr 2026 16:16:46 -0700 (PDT)
X-Received: by 2002:a05:7301:df48:b0:2ed:e17:d50e with SMTP id
 5a478bee46e88-2ed0e17d729mr1348210eec.33.1777418206307; 
 Tue, 28 Apr 2026 16:16:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf6d391sm450749eec.6.2026.04.28.16.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 16:16:45 -0700 (PDT)
Message-ID: <24ba9372-a691-4a63-a6da-e8340343faaf@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:16:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Rust builds don't use link_args
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a/0AM0SF c=1 sm=1 tr=0 ts=69f13fdf cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=hQf6nhcqaVJ33rJOARMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: XLNZl3TfEkgL70w6xgGyLsmBvS7TK0wm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDIyOSBTYWx0ZWRfX/BAo71fry4TX
 zMhNoV82hBGnPri4cEpx/gWi5RYP6MijpXPJ4oT43IU6Kt/OioopZsefxGb3pgj0ZztFCXxBmNn
 cQUwgdK2mydfjDoVfqPOUq1pPSPOWpP1nWBkU1Xl+mQreJdot6DNNnE88eli4piX3p6cc+JM2zG
 A4PBwszTQRLgdQz9xeVxiEIxlsKjfKK93skvRxbfJF6huo2U364CzYnTdh8BU+kSWJ4p9fnb/pm
 vsBRUT9jl0yg1GL+86v9JMgNtsjcLkMuJ6iyVHVRFw0Ii8aa0RUo10g+0JVMDlgJFeCgFIWsCF0
 vfLTuO6Q56L/x28SbIAmYZGdRyxQ+RK4/UrcqqqjoXkXya4l93pNmwBaKbZ/VjC7CVTgk3qjQTc
 5jA215Np2hK0x8R+2zYe5FaWMzZ1TOp979XF1FX4ldD/eo25qUn7xMMxd0p0x9Xh+q66vh+I/a4
 Ks9FG8cSMaRYEDh5pKg==
X-Proofpoint-GUID: XLNZl3TfEkgL70w6xgGyLsmBvS7TK0wm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280229
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

I noticed that plugins are not working when building with with
--enable-rust.

$ ./configure --enable-rust --target-list=aarch64-softmmu
$ ./build/qemu-system-aarch64 -M virt -nographic -plugin
./build/tests/tcg/plugins/libdiscons.so
qemu-system-aarch64: Could not load plugin ../plugins/libdiscons.so:
../plugins/libdiscons.so: undefined symbol: qemu_plugin_bool_parse

We explicitly export qemu_plugin_* symbols from QEMU binary using:
plugins/meson.build:24 [1]
```
emulator_link_args += '-Xlinker', '--dynamic-list=' +
qemu_plugin_symbols.full_path()
```

Tracing a rust enabled build, it seems that rustc is responsible for
doing the final link, by calling the compiler (cc here).
However, I didn't see those flags being passed.

It doesn't seem like we do anything funky in rust/* for that magic, so I
suspect meson is doing something wrong here. I prefer to ask before
falling into a rabbit hole.

Any idea how to make rustc apply these flags correctly?

[1]
https://gitlab.com/qemu-project/qemu/-/blob/master/plugins/meson.build?ref_type=heads#L24

Regards,
Pierrick

