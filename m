Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46916C43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegaj-00014Z-8r; Tue, 30 Jun 2026 18:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegYM-0003zk-Ba
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegYK-0004Fo-SG
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:38 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDX7x2942523
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GVNbbIjqhbtFIpRBVLuj1zsz36lqLsE5BS8cy9LUoPk=; b=Yl67PqgNv0DM+FZQ
 B1WFowkx77MIUQTQgt50cnjscJzkYP0EL55PxCrXf2fWJ7sVvTA56534BewkrvGS
 dgFnHH+2Dbp4T5uUolyAYGNnsfYyE83JiLXQz3cwmJ9GhZ1zP81Lm0TELH824M2l
 w9OG/uoZ5Ms1w1uw/YzOsSm+4mQm7rAo+HeSdzsQD6DlfJyrujfW2m6XuXQL/9+M
 giR7cCMVNrC7aPilI2olhLpR2WrLfyyYf6zmuKm87UXWlGAbRbICZt/KFYPhEY+H
 C5TKhnHck17/uG4CMEY/ifDdeTONQpdfXpxsd2jREbZTPYV9wuNt0tKrRkx52QPd
 SJyYfw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99h474-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:03:35 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9692df7e2feso1397960241.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857014; x=1783461814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVNbbIjqhbtFIpRBVLuj1zsz36lqLsE5BS8cy9LUoPk=;
 b=JVB17yhNrCCX8E120V+gNYunhUiwPJi/+dOTuA/Y/5zMgJWULdA1sb/qZVgKXNQE1+
 IHsUJXBVbVmF3yt902bqxFNDK2AnveaYo2jmizz+xYlC/OpQhIGKLFr6s+G8FzZs9JEU
 xDsulLUQf/ogX7msytRX/T6P8FOO4OhpYdhZADu7pafAbguCRikq9ClMNtBcLIlRR5UP
 QBh5JeKVO6GsB0HrZ+82PFRUHk0zoKqFcErJeLs7x1rV2wtGG+VNlrfuT/yFzOcNPzoT
 DXlmKgyFLKhD3y2P5t3Ns20lglz/nwDvc8YalD8dMcsZ2FuRbto3aZE/UyghiBdeINqT
 crNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857014; x=1783461814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GVNbbIjqhbtFIpRBVLuj1zsz36lqLsE5BS8cy9LUoPk=;
 b=Ll/TUqan0aL3AnTbLztABLQfJwrgQaSmX1KKe9m3f4fLIoNcfFUYZKySZP44hXOJ/7
 Y5mECklkI37VNwAXFvFLF3svprFANfmg/D2APaAry5wKX+o24NXZzXs+SheySAMXy+pE
 f77X2wZJJ4GOhyaaZKUJn+lC+Xf/BKCwLPvu0ZHuFrbAV8WiWOERF56B7jrLdL6mSVBb
 oVqWh0gy1H687Ve1bRjdYqSL2/Cc14w7JijdtaIcf6CPZjXGzYoTeBycLmGd7ekJnz4m
 807upwzOQHTYpsxauzT8bkrELz7DFLODPUAuCSvCqB63lex60hGciqb0bX/M5LvhPpnc
 or6g==
X-Gm-Message-State: AOJu0YzjnhLz9wJcdHNBWPfVjkb/VnmgOwMlKJcPMAFGMm/aLWhLu2PK
 Cvx6Y1F6EoRrj+xT6pe/nBdey1eAs/3AV1aC/Ald640u4gDk8BnwWPF9T6XKwMFhqoMXDRDNR8+
 /VTqAZdykoz72rnvmFGOuImeupx0QOs1a2BX1LVhBt2GPoEPPkpsAQcXtBmXETsUujQ==
X-Gm-Gg: AfdE7ckFvHIjeX8UU0Oilb6b3f4rRGAxUV7xTQFcoPcC2N+BLoIbVa/wvwZ+u3WhjRX
 19jv3KPhDG8sVGs2Yepoccpehb/CwvI5xg9FHunVmsJgxw73MzNAhWInyY0CQIpfkhFMCPytBTK
 Ei9JzYVnIvzeXgpEjbt5HhoIT+npqnStSOJSSYJVfBzZshfyKkTPlR/6aoYu0Qnq7v8aHzOTbxv
 w4/T0VdE+Kpb+XOmedsNSx4yaQBFgM3VcbTTJ/2oFLJ/x35nhxueLI3pVFiGPj3AD5XHdOhEM/L
 keZpH+hz0ISGgR2msA5JM/wzEoVFJYOERgoxX2uLbCrlMLb6qfNuuJ4x2xfJ4J8/0EUe4S/3fS3
 CRbJXpLwU4A3OOoH6DJQXCCHUc4jkwLZIACRL2sInNtsNJ2WjfF/dAaXgR6ucRsEADg/g
X-Received: by 2002:a05:6102:6442:b0:737:9003:ac4c with SMTP id
 ada2fe7eead31-73a36bf1f6dmr2269273137.10.1782857014311; 
 Tue, 30 Jun 2026 15:03:34 -0700 (PDT)
X-Received: by 2002:a05:6102:6442:b0:737:9003:ac4c with SMTP id
 ada2fe7eead31-73a36bf1f6dmr2269251137.10.1782857013903; 
 Tue, 30 Jun 2026 15:03:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4d2bc5sm25438705e9.5.2026.06.30.15.03.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:03:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 20/33] gdbstub/user: Directly call gdb_breakpoint_remove_all()
 in user mode
Date: Wed,  1 Jul 2026 00:00:47 +0200
Message-ID: <20260630220100.1289-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX/tReSmcmr2cZ
 wNpKfrWcNcFgT9tVD3zc5YUCMghm9twNRe4MyGA5pdcJlZVcVroSgE3gDxxdTPJ1nWLHNHt9+w0
 8CnbbD8Gqc0OBt8QY7MIigWz6ujHLek=
X-Proofpoint-ORIG-GUID: 4n4xqrwSkXHYFPNuTswSghsN2zmBk4jX
X-Proofpoint-GUID: 4n4xqrwSkXHYFPNuTswSghsN2zmBk4jX
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a443d37 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=zxLOgqzoZ8asriTz2EMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX1T/JC8LQtPfJ
 8fsip9HVqatkSZgC2p/7cp8nL6dZlGSKnXYQUbH1Zy/UwnWhrlwvMYAQEU3w6EorbKt6jymbZiD
 rxMX3u9uJm4l5Oj+5ikLLn9IjWwlbfBZLX3d7yvsOgE/XAzoTGD0I5k9RYKBuBB7NSxiiAPPrjJ
 W1BKcPZnkiwoQ6jfd7WCRiOcqucxdY69QZdBG2rTzh3l5Wcj6ZkqJiGawVryJx1M0MDgowbGZVS
 ic2ctJhJxJU1BGN+M2bs3NuFQ3YOGVn/E7uhc5wlSmlvifV4gZSLOjxaDrp23JRRl9ml4Q0uSMS
 X0XY3IiG8p0ih6ICfk/xqTnTSzzQkBttBOmXzlw+NxYefL8WGrtTfVna1kn5by0wvWNe5/+93Nd
 NwO1FzLXVLU5mjg0+TJxj4ebGcKUip5m6ZvpQ2XEDUVJF7oQ1Hzjb0K+jmOMjZOcftPnu48JG7s
 Rh5lYLLBwqdKkQgwNpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300215
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

No need to deref external methods with unused argument to
end up calling a method defined in the same unit file, call
it directly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 gdbstub/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 299388b9f71..90d6ee49fb5 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -557,7 +557,7 @@ static void disable_gdbstub(CPUState *thread_cpu)
     close(gdbserver_user_state.fd);
     gdbserver_user_state.fd = -1;
     CPU_FOREACH(cpu) {
-        cpu_breakpoint_remove_all(cpu, BP_GDB);
+        gdb_breakpoint_remove_all(cpu);
         /* no cpu_watchpoint_remove_all for user-mode */
         cpu_single_step(cpu, 0);
     }
-- 
2.53.0


