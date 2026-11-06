Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A47606A337
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I0hkhIWd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R8qaNRA/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPPEv-0008H6-Rt; Fri, 06 Nov 2026 14:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPEM-0008DS-Qb
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:04:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPEL-0007F2-7Z
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:04:06 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Ht1j7432016
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 19:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7Yqz6XhQX16M0YRbis/B11IeirhDwcDkM/Voo7pahhk=; b=I0hkhIWdqAc76O3t
 wv16bwKtI/20sgOf9bAPGoJLEgIU9RE9/lELyfaS5s38jRbUt6Kx8mT/vCCJ4IWz
 /SgOf7MX8ommWJ8d0mnkg6RdMYTMzY5/z5eWG+Nn4IXqqLCpT3l616zovr4X9W0f
 YJLZi+ud0v4Tub+Nul1o5HpKYCrUsOj4Jx3kkchgt6XOA5rKiMHWpCExAz9IWU7h
 Dlcezq86FhpL1SjRBXChYPhqe3/UQZGuxR3RlzI+Hsl4nKOPC3rNx5Eql9iu5wvc
 4kcJqKxL/VPVWCZUE+V7rm7gyNJSIwdj/Do40vygkm/mwg6+wOYS1KbIXDZf3aJX
 dZDEsg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa48bs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 19:04:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e95f8543c9so12321315ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 11:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793991843; x=1794596643; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7Yqz6XhQX16M0YRbis/B11IeirhDwcDkM/Voo7pahhk=;
 b=R8qaNRA/5gEa65eTs3ukugyR0o4UuE57ygWVYkpOVjXC4HGn05AGfyhVj5dL9f9Af6
 an4dSweFI7mYvPCUk+e2la1FWnmLdVQ3Y5OswQb0pcqqMLA3Rrz2bmiIrIRO/B8pZR7n
 EM3sQxVMugk+5kHN3cw3QQJy4LDBfQsu/NjqrFpwg/j1hSuPy2jEsPtBMwiE3elyxCur
 u4PV86Fa8Lbg0oCY3hRbGy1AbuJz5YRvVZQbdheViSxXsJPXHYuL1sBTyJT9N9AxrIsc
 iCZ9GKWs2yizqyui3F83UjcLQbC4+up3u7uFMlom2AAvwgw/Dckfz7ZL5q1O9yGaTzd8
 BsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793991843; x=1794596643;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Yqz6XhQX16M0YRbis/B11IeirhDwcDkM/Voo7pahhk=;
 b=Nue7LVD5Ont0MHOZH9jy92DDm/VtU9r1SLW85qGzKm9ux1V4WsIXGN7c0OfTFLTA3i
 hln341vsKfSXuNElO7ZR9JALv9DwrQyYdXfHdqSaZucPeZOBH0AtpLaIeFqTl8Wrmxza
 fln6WmBziT7wdmXBdfkVhpAIeMc0V5KJZaslDjB2NT/Cjupm8MZD7i6mMAEfVIHQWR1b
 lUoJPPjNEnH24c1+oxL+LEuYapNIESwq3tYM7hHrsKucM7bgGMcsPmysZ4Nz/tNxmVL3
 PkuICviIw9qlzYomEpwLlTEeWRvpUnx23h1hJIFVebQym7K0nKXxKXMGrSBpGwPKSZcF
 1EEw==
X-Gm-Message-State: APuU4Z+E8tZJm6SDebLuPtEtsc8QAvRc4W3W3E+vhIsSirVe8qIVTcX9
 PUQ5EveExxyqR864zTg9W0jipGkTbfrsNDVDIUWPkdClOVVRT6FE8hgZmBMxxsRwZkARTfrY+Qr
 ZUQbKdgKjzlaJtXnfIotKTvLZ3hbqz1GmBJQG2d3WXX3HA/5y/82zQ9yzvnHc2xgVZA==
X-Gm-Gg: AYBFou1YwJFm4SCYztR9cEH6vN3q3hh60WvZUNtJsjqLeF9NGL2iC7oyM2zgACeEOUt
 GR8nXKpBffLtG/1gRdsGcgfydCHxTKEX9oQJaFgOUexae42yVoKzbLAOzjL9L1ywYmWQ+aDcNgh
 1LWH+ogsbPz17PIstk41FvWaJfPZyb+UBOkVz6vXo+rsSijfDW2bia/aV1XzxwJLZH+RUhyLft/
 A1nFtAV1lYscq8Jk6DSxVU5QiRSIOW7zzXlWIkiUGnftx85gMvF95J66TaCjX1rs6uYrThhXNv2
 LJgRdQ8EEwKC+Z5ooyVFQLTMEBVo8Izuxf6HL4Nt1K3kUa3V+5s5LZdsf/lefebcEZC28EPrtiG
 I5esz3SbsHHZZvpNBlvFomQ/KIByB58bbIOmZia+AhjjYn04fjYax7jG6tQ06PFUMxCRWwAgckg
 qg1nmMaVYB3kfnMh7cWyXxMHQs4KFR9Z26NX4T
X-Received: by 2002:a17:902:e74f:b0:2ed:28b2:84b8 with SMTP id
 d9443c01a7336-2ed412f7d2dmr46482505ad.8.1793991842767; 
 Fri, 06 Nov 2026 11:04:02 -0800 (PST)
X-Received: by 2002:a17:902:e74f:b0:2ed:28b2:84b8 with SMTP id
 d9443c01a7336-2ed412f7d2dmr46482135ad.8.1793991842288; 
 Fri, 06 Nov 2026 11:04:02 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47d40d19sm8283735ad.32.2026.11.06.11.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:04:00 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/5] tests/lcitool: add mips32r6el toolchain to refresh script
Date: Fri,  6 Nov 2026 12:03:49 -0700
Message-ID: <20261106190352.1665081-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106190352.1665081-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261106190352.1665081-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aee24a3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=hUUzPJS6sRhIDJmEFTkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX81poeoqRC7U5
 2ZlnMknb+3bsCx54Q/l+K2jzmstoVkHEu7Dix8J+RZ02HFklu80yPW+YbfnD8xXR30lDjceLnBy
 Gv4fAZya2H4ypy3hLbEJOU5XcrugIfE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX1kVfWUMWuMHD
 CApRxhwdeYBDTfk1K0TR/zWFH7c5X4XU7NIQjAubBC33qTRK8lGaNPVT4Gnjs/DHmlWf6zpekc3
 PtrzUgkcIcFJ5SNsiXxzJ3zL4csZKuFiM9I+Jy2pMyVSBUJqG6wXCSikSSkS/vPMqvNR/0u3rBx
 qbBxO2QwSgMQTwkj7n/3iirdvtpX5ONV5Jiy+vm8Wg2VAsHHhJID0+SPBkFkbJnT2lTnODvVAFw
 LWHeadFw85ZcwGDeL9hqBu3PmayrP1I/fJMszYvAYcJAG7et5UJRLPBnkzM9Blk5wUxcDrxbi8R
 aFZisPsd8dvKq0cCTe9PPp6BHtivRR04z1vx0RhVRbOVEcUVdTekN66UVjcelVOicJcXnnerCJC
 /+GnR6IF/P8B9KV6i4ihSSHu/7/lgBukhMvWHwgudcLUE6T+7JQmohVI5XuuHorYX6iQXxu6FX+
 pAYRzPL6BivMihNCS9Q==
X-Proofpoint-GUID: lAZaSA2DnRMsYgWAXTEz5mhqzaCkaTPX
X-Proofpoint-ORIG-GUID: lAZaSA2DnRMsYgWAXTEz5mhqzaCkaTPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060075
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel P. Berrangé <berrange@redhat.com>

The debian-all-test-cross.docker file is auto-generated so
the extra toolchains need to be listed in the prologue
in the refresh script.

Fixes: ace0b0b3d104 ("tests/docker: Add the mips32r6el toolchain on Debian cross container")
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261106171836.2020151-3-berrange@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/lcitool/refresh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 94cab24bbdb..075acb82e1d 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -200,6 +200,8 @@ RUN apt update && \
   libc6-dev-mips64el-cross \
   gcc-mipsel-linux-gnu \
   libc6-dev-mipsel-cross \
+  gcc-mipsisa32r6el-linux-gnu \
+  libc6-dev-mipsr6el-cross \
   gcc-mipsisa64r6-linux-gnuabi64 \
   libc6-dev-mips64r6-cross \
   gcc-mipsisa64r6el-linux-gnuabi64 \
-- 
2.47.3


